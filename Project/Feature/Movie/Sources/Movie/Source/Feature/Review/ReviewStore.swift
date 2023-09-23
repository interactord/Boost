import Foundation
import ComposableArchitecture

public struct ReviewStore {
  let pageID: String
  let env: ReviewEnvType
  
  init(pageID: String = UUID().uuidString, env: ReviewEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

extension ReviewStore {
  public struct State: Equatable {
  }
}

extension ReviewStore.State {
}

extension ReviewStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

extension ReviewStore: Reducer {
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
