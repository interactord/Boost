import Architecture
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

    init() {
      _fetchNowPlaying = .init(.init(isLoading: false, value: .init()))
    }

    @Heap var fetchNowPlaying: FetchState.Data<MovieDomain.MovieList.Response.NowPlay>
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
        state.fetchNowPlaying.isLoading = true
        let currentPage = state.fetchNowPlaying.value.resultList.count / 20
        return env.nowPlaying(currentPage + 1)
          .map(Action.fetchNowPlay)
          .cancellable(pageID: pageID, id: CancelID.requestNowPlay, cancelInFlight: true)

      case .onUpdateKeyword:
        print(state.keyword)
        return .none

      case .onClearKeyword:
        print("onClearKeyword")
        return .none

      case .fetchNowPlay(let result):
        state.fetchNowPlaying.isLoading = false
        switch result {
        case .success(let content):
          state.fetchNowPlaying.value = state.fetchNowPlaying.value.merge(target: content)
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .throwError(let error):
        print(error)
        return .none
      }
    }
  }
}

extension MovieDomain.MovieList.Response.NowPlay {
  fileprivate func merge(target: Self) -> Self {
    .init(
      totalPages: target.totalPages,
      totalResult: target.totalResult,
      page: target.page,
      resultList: resultList.mergeUnique(target: target.resultList))
  }
}

extension [MovieDomain.MovieList.Response.ResultItem] {
  fileprivate func mergeUnique(target: Self) -> Self {
    target.reduce(self) { curr, next in
      curr + (curr.map(\.id).contains(next.id) ? [] : [next])
    }
  }
}
