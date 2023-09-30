import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CastStore

public struct CastStore {
  let pageID: String
  let env: CastEnvType

  init(pageID: String = UUID().uuidString, env: CastEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: CastStore.State

extension CastStore {
  public struct State: Equatable {
    let movieID: Int

    init(movieID: Int) {
      self.movieID = movieID
      _fetchMovieCast = .init(.init(isLoading: false, value: .init()))
    }

    @Heap var fetchMovieCast: FetchState.Data<MovieDetailDomain.Response.MovieCreditResult>
  }
}

extension CastStore.State { }

// MARK: - CastStore.Action

extension CastStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getMovieCast

    case fetchMovieCast(Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>)

    case throwError(CompositeErrorDomain)
  }
}

// MARK: - CastStore.CancelID

extension CastStore {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestMovieCast
  }
}

// MARK: - CastStore + Reducer

extension CastStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .merge(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getMovieCast:
        state.fetchMovieCast.isLoading = false
        return .merge(
          env.movieCredit(state.movieID)
            .map(Action.fetchMovieCast)
            .cancellable(pageID: pageID, id: CancelID.requestMovieCast, cancelInFlight: true))

      case .fetchMovieCast(let result):
        state.fetchMovieCast.isLoading = false
        switch result {
        case .success(let content):
          state.fetchMovieCast.value = content
          return .none
        case.failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .throwError(let error):
        print(error)
        return .none
      }
    }
  }
}
