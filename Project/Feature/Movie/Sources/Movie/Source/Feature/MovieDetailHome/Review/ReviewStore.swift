import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ReviewStore

public struct ReviewStore {
  let pageID: String
  let env: ReviewEnvType

  init(pageID: String = UUID().uuidString, env: ReviewEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: ReviewStore.State

extension ReviewStore {
  public struct State: Equatable {
    let movieID: Int

    init(movieID: Int) {
      self.movieID = movieID
      _fetchMovieReview = .init(.init(isLoading: false, value: .init()))
    }

    @Heap var fetchMovieReview: FetchState.Data<MovieDetailDomain.Response.MovieReviewResult>
  }
}

extension ReviewStore.State { }

// MARK: - ReviewStore.Action

extension ReviewStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getMovieReview

    case fetchMovieReview(Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>)

    case throwError(CompositeErrorDomain)
  }
}

// MARK: - ReviewStore.CancelID

extension ReviewStore {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestMovieReview
  }
}

// MARK: - ReviewStore + Reducer

extension ReviewStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getMovieReview:
        state.fetchMovieReview.isLoading = false
        return .concatenate(
          env.movieReview(state.movieID)
            .map(Action.fetchMovieReview)
            .cancellable(pageID: pageID, id: CancelID.requestMovieReview, cancelInFlight: true))

      case .fetchMovieReview(let result):
        state.fetchMovieReview.isLoading = false
        switch result {
        case .success(let content):
          state.fetchMovieReview.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .throwError(let error):
        print(error)
        return .none
      }
    }
  }
}
