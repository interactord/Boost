import Foundation
import ComposableArchitecture

public struct MovieHomeStore {

  let pageID: String
  let env: MovieHomeEnvType

  init(pageID: String = UUID().uuidString, env: MovieHomeEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

extension MovieHomeStore {
  public struct State: Equatable {
    @BindingState var keyword = ""
    @BindingState var searchFocus: SearchType = .movies
  }
}

extension MovieHomeStore.State {
  public enum SearchType: Int, Equatable {
    case movies
    case people
  }
}

extension MovieHomeStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case onUpdateKeyword
    case onClearKeyword
  }
}

extension MovieHomeStore: Reducer {

  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .none

      case .onUpdateKeyword:
        print(state.keyword)
        return .none

      case .onClearKeyword:
        print("onClearKeyword")
        return .none
      }
    }
  }
}
