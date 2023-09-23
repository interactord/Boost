import Foundation
import ComposableArchitecture

public struct CrewStore {
  let pageID: String
  let env: CrewEnvType
  
  init(pageID: String = UUID().uuidString, env: CrewEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

extension CrewStore {
  public struct State: Equatable {
  }
}

extension CrewStore.State {
}

extension CrewStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

extension CrewStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .teardown:
        return .none
      }
    }
  }
}
