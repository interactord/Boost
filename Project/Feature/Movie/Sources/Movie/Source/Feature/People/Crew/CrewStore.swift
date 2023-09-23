import ComposableArchitecture
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
  public struct State: Equatable { }
}

extension CrewStore.State { }

// MARK: - CrewStore.Action

extension CrewStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

// MARK: - CrewStore + Reducer

extension CrewStore: Reducer {
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
