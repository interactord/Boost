import ComposableArchitecture
import Foundation

// MARK: - MovieDetailStore

public struct MovieDetailStore {
  let pageID: String
  let env: MovieDetailEnvType
  init(pageID: String = UUID().uuidString, env: MovieDetailEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: MovieDetailStore.State

extension MovieDetailStore {
  public struct State: Equatable { }
}

extension MovieDetailStore.State { }

// MARK: - MovieDetailStore.Action

extension MovieDetailStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

// MARK: - MovieDetailStore + Reducer

extension MovieDetailStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { _, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .none
      }
    }
  }
}
