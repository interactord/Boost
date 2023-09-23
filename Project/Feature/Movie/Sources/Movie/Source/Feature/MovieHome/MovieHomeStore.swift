import Architecture
import ComposableArchitecture
import Domain
import Foundation

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
      _fetchSearchKeyword = .init(.init(isLoading: false, value: .init()))
      _fetchSearchMovie = .init(.init(isLoading: false, value: .init()))
      _fetchSearchPeople = .init(.init(isLoading: false, value: .init()))
    }

    @Heap var fetchNowPlaying: FetchState.Data<MovieDomain.MovieList.Response.NowPlay>
    @Heap var fetchSearchKeyword: FetchState.Data<SearchDomain.Response.KeywordResult?>
    @Heap var fetchSearchMovie: FetchState.Data<SearchDomain.Response.MovieResult?>
    @Heap var fetchSearchPeople: FetchState.Data<SearchDomain.Response.PeopleResult?>
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
    case fetchSearchKeyword(Result<SearchDomain.Response.KeywordResult, CompositeErrorDomain>)
    case fetchSearchMovie(Result<SearchDomain.Response.MovieResult, CompositeErrorDomain>)
    case fetchSearchPeople(Result<SearchDomain.Response.PeopleResult, CompositeErrorDomain>)

    case throwError(CompositeErrorDomain)
  }
}

// MARK: - MovieHomeStore.CancelID

extension MovieHomeStore {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestNowPlay
    case requestSearchKeyword
    case requestSearchMovie
    case requestSearchPeople
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
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getNowPlay:
        state.fetchNowPlaying.isLoading = true
        let currentPage = state.fetchNowPlaying.value.resultList.count / 20
        return env.nowPlaying(currentPage + 1)
          .map(Action.fetchNowPlay)
          .cancellable(pageID: pageID, id: CancelID.requestNowPlay, cancelInFlight: true)

      case .onUpdateKeyword:
        guard !state.keyword.isEmpty else { return .run { await $0(.onClearKeyword) } }
        return .concatenate(
          env.searchKeyword(state.keyword)
            .map(Action.fetchSearchKeyword)
            .cancellable(pageID: pageID, id: CancelID.requestSearchKeyword, cancelInFlight: true),
          env.searchMovie(state.keyword)
            .map(Action.fetchSearchMovie)
            .cancellable(pageID: pageID, id: CancelID.requestSearchMovie, cancelInFlight: true),
          env.searchPeople(state.keyword)
            .map(Action.fetchSearchPeople)
            .cancellable(pageID: pageID, id: CancelID.requestSearchPeople, cancelInFlight: true))

      case .onClearKeyword:
        state.fetchSearchKeyword = .init(isLoading: false, value: .none)
        state.fetchSearchMovie = .init(isLoading: false, value: .none)
        state.fetchSearchPeople = .init(isLoading: false, value: .none)
        state.searchFocus = .movies
        return .concatenate(
          .cancel(pageID: pageID, id: CancelID.requestSearchKeyword),
          .cancel(pageID: pageID, id: CancelID.requestSearchMovie),
          .cancel(pageID: pageID, id: CancelID.requestSearchPeople))

      case .fetchNowPlay(let result):
        state.fetchNowPlaying.isLoading = false
        switch result {
        case .success(let content):
          state.fetchNowPlaying.value = state.fetchNowPlaying.value.merge(target: content)
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchKeyword(let result):
        state.fetchSearchKeyword.isLoading = false
        switch result {
        case .success(let content):
          state.fetchSearchKeyword.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchMovie(let result):
        state.fetchSearchMovie.isLoading = false
        switch result {
        case .success(let content):
          state.fetchSearchMovie.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchPeople(let result):
        state.fetchSearchPeople.isLoading = false
        switch result {
        case .success(let content):
          state.fetchSearchPeople.value = content
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
