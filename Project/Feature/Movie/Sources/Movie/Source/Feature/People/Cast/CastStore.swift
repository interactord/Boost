import ComposableArchitecture
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
  public struct State: Equatable { }
}

extension CastStore.State { }

// MARK: - CastStore.Action

extension CastStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

// MARK: - CastStore + Reducer

extension CastStore: Reducer {
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
