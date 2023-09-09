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
  }
}

extension MovieHomeStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

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
      }
    }
  }
}
