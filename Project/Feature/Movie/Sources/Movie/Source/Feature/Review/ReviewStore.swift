import ComposableArchitecture
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
  public struct State: Equatable { }
}

extension ReviewStore.State { }

// MARK: - ReviewStore.Action

extension ReviewStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

// MARK: - ReviewStore + Reducer

extension ReviewStore: Reducer {
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
