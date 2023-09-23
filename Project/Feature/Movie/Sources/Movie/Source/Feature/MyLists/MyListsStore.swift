import ComposableArchitecture
import Foundation

// MARK: - MyListsStore

public struct MyListsStore {
  let pageID: String
  let env: MyListsEnvType
  init(pageID: String = UUID().uuidString, env: MyListsEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: MyListsStore.State

extension MyListsStore {
  public struct State: Equatable {
    @BindingState var listFocus: ListType = .wish
  }
}

// MARK: - MyListsStore.State.ListType

extension MyListsStore.State {
  public enum ListType: Int, Equatable {
    case wish
    case seen
  }
}

// MARK: - MyListsStore.Action

extension MyListsStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
  }
}

// MARK: - MyListsStore + Reducer

extension MyListsStore: Reducer {
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
