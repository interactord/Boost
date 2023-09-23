import Foundation
import ComposableArchitecture

public struct CastStore {
  let pageID: String
  let env: CastEnvType
  
  init(pageID: String = UUID().uuidString, env: CastEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

extension CastStore {
  public struct State: Equatable {
  }
}

extension CastStore.State {
}

extension CastStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

extension CastStore: Reducer {
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
