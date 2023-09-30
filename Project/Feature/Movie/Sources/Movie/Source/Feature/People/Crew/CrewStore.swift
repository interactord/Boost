import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CrewStore

public struct CrewStore {
  let pageID: String
  let env: CrewEnvType

  init(pageID: String = UUID().uuidString, env: CrewEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: CrewStore.State

extension CrewStore {
  public struct State: Equatable {
    let movieID: Int

    init(movieID: Int) {
      self.movieID = movieID
      _fetchMovieCrew = .init(.init(isLoading: false, value: .init()))
    }

    @Heap var fetchMovieCrew: FetchState.Data<MovieDetailDomain.Response.MovieCreditResult>
  }
}

extension CrewStore.State { }

// MARK: - CrewStore.Action

extension CrewStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getMovieCrew

    case fetchMovieCrew(Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>)

    case throwError(CompositeErrorDomain)
  }
}

// MARK: - CrewStore.CancelID

extension CrewStore {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestMovieCrew
  }
}

// MARK: - CrewStore + Reducer

extension CrewStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getMovieCrew:
        state.fetchMovieCrew.isLoading = false
        return .concatenate(
          env.movieCredit(state.movieID)
            .map(Action.fetchMovieCrew)
            .cancellable(pageID: pageID, id: CancelID.requestMovieCrew, cancelInFlight: true))

      case .fetchMovieCrew(let result):
        state.fetchMovieCrew.isLoading = false
        switch result {
        case .success(let content):
          state.fetchMovieCrew.value = content
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
