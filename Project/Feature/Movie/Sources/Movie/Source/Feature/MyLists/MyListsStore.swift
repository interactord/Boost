import Foundation
import ComposableArchitecture

public struct MyListsStore {
  let pageID: String
  let env: MyListsEnvType
  init(pageID: String = UUID().uuidString, env: MyListsEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

extension MyListsStore {
  public struct State: Equatable {
    @BindingState var listFocus: ListType = .wish
  }
}

extension MyListsStore.State {
  public enum ListType: Int, Equatable {
    case wish
    case seen
  }
}

extension MyListsStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}


extension MyListsStore: Reducer {
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
