import ComposableArchitecture
import Foundation
import Domain

// MARK: - MovieHomeStore

public struct MovieHomeStore {
  let pageID: String
  let env: MovieHomeEnvType
  init(pageID: String = UUID().uuidString, env: MovieHomeEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: MovieHomeStore.State

extension MovieHomeStore {
  public struct State: Equatable {
    @BindingState var keyword = ""
    @BindingState var searchFocus: SearchType = .movies
  }
}

// MARK: - MovieHomeStore.State.SearchType

extension MovieHomeStore.State {
  public enum SearchType: Int, Equatable {
    case movies
    case people
  }
}

// MARK: - MovieHomeStore.Action

extension MovieHomeStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getNowPlay

    case onUpdateKeyword
    case onClearKeyword

    case fetchNowPlay(Result<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain>)
    case throwError(CompositeErrorDomain)
  }
}

extension MovieHomeStore {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestNowPlay
  }
}

// MARK: - MovieHomeStore + Reducer

extension MovieHomeStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map{ .cancel(pageID: pageID, id: $0) })

      case .getNowPlay:
        print("getNowPlay")
        return .none

      case .onUpdateKeyword:
        print(state.keyword)
        return .none

      case .onClearKeyword:
        print("onClearKeyword")
        return .none

      case .fetchNowPlay(let result):
        return .none

      case .throwError(let error):
        print(error)
        return .none
      }
    }
  }
}
