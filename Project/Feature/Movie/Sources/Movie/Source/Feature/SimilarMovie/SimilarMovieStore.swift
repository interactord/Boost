import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SimilarMovieStore

public struct SimilarMovieStore {
  let pageID: String
  let env: SimilarMovieEnvType
  init(pageID: String = UUID().uuidString, env: SimilarMovieEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: SimilarMovieStore.State

extension SimilarMovieStore {
  public struct State: Equatable {
    let movieID: Int

    init(movieID: Int) {
      self.movieID = movieID
      _fetchSimilarMovie = .init(.init(isLoading: false, value: .init()))
    }

    @Heap var fetchSimilarMovie: FetchState.Data<MovieDetailDomain.Response.SimilarMovieResult>
  }
}

// MARK: - MyListsStore.State.ListType

extension SimilarMovieStore.State { }

// MARK: - SimilarMovieStore.Action

extension SimilarMovieStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getSimilarMovie

    case fetchSimilarMovie(Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>)

    case throwError(CompositeErrorDomain)
  }
}

// MARK: - SimilarMovieStore.CancelID

extension SimilarMovieStore {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestSimilarMovie
  }
}

// MARK: - SimilarMovieStore + Reducer

extension SimilarMovieStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getSimilarMovie:
        state.fetchSimilarMovie.isLoading = false
        return .concatenate(
          env.similarMovie(state.movieID)
            .map(Action.fetchSimilarMovie)
            .cancellable(pageID: pageID, id: CancelID.requestSimilarMovie, cancelInFlight: true))

      case .fetchSimilarMovie(let result):
        state.fetchSimilarMovie.isLoading = false
        switch result {
        case .success(let content):
          state.fetchSimilarMovie.value = content
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
