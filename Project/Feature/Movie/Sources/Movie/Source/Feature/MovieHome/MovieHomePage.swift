import Architecture
import ComposableArchitecture
import DesignSystem
import Foundation
import SwiftUI

// MARK: - MovieHomePage

struct MovieHomePage {

  private let store: StoreOf<MovieHomeStore>
  @ObservedObject private var viewStore: ViewStoreOf<MovieHomeStore>
  @FocusState private var isFocus: Bool?

  init(store: StoreOf<MovieHomeStore>) {
    self.store = store
    viewStore = ViewStore(store, observe: { $0 })
  }
}

extension MovieHomePage {
  private var searchComponentViewState: SearchComponent.ViewState {
    .init(placeHolder: "Serch any movies or person")
  }

  private var itemListComponentViewState: ItemListComponent.ViewState {
    .init(rawValue: viewStore.fetchNowPlaying.value.resultList)
  }

  private var searchResultMoviesComponentViewState: SearchResultMoviesComponent.ViewState {
    .init(
      fetchSearchMovie: viewStore.fetchSearchMovie.value,
      fetchSearchKeyword: viewStore.fetchSearchKeyword.value)
  }

  private var searchResultPeopleComponenetViewState: SearchResultPeopleComponenet.ViewState {
    .init(rawValue: viewStore.fetchSearchPeople.value)
  }
}

extension MovieHomePage {
  private var isLoading: Bool {
    viewStore.fetchNowPlaying.isLoading
      || viewStore.fetchSearchMovie.isLoading
      || viewStore.fetchSearchKeyword.isLoading
  }
}

// MARK: View

extension MovieHomePage: View {

  var body: some View {
    VStack {
      // 서치뷰
      SearchComponent(
        viewState: searchComponentViewState,
        keyword: viewStore.$keyword,
        isFocus: $isFocus,
        throttleAction: { viewStore.send(.onUpdateKeyword) },
        clearAction: {
          viewStore.send(.onClearKeyword)
          isFocus = false
        })
        .padding(.trailing, 16)
        .padding(.bottom, 8)

      Divider()

      // 아이템 리스트
      ItemListComponent(
        viewState: itemListComponentViewState,
        nextPageAction: { viewStore.send(.getNowPlay) },
        selectAction: { viewStore.send(.onSelectMovieItem($0)) })
        .overlay {
          if isFocus ?? false {
            VStack {
              Picker("", selection: viewStore.$searchFocus) {
                Text("Movies").tag(MovieHomeStore.State.SearchType.movies)
                Text("People").tag(MovieHomeStore.State.SearchType.people)
              }
              .pickerStyle(SegmentedPickerStyle())
              .padding(.trailing, 16)

              Divider()

              switch viewStore.searchFocus {
              case .movies:
                // 서치 했을때의 무비 리스트
                SearchResultMoviesComponent(
                  viewState: searchResultMoviesComponentViewState)

              case .people:
                // 서치 했을때의 사람 리스트
                SearchResultPeopleComponenet(
                  viewState: searchResultPeopleComponenetViewState)
              }

              Spacer()
            }
            .background(.white)
          }
        }

      Spacer()
    }
    .padding(.leading, 16)
    .background(.white)
    .navigationTitle("Now Playing")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: { }) {
          Image(systemName: "gearshape")
            .resizable()
            .foregroundColor(.customYellowColor)
        }
        .animation(.none, value: viewStore.state) // 특정한 곳에 애니메이션 주기 싫을때
      }
    }
    .animation(.spring(), value: viewStore.state)
    .setRequestFlightView(isLoading: isLoading)
    // 키보드가 내려 갈대 다른 아이템이 보이지 않게 하기 위해
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .onAppear {
      viewStore.send(.getNowPlay)
    }
    .onDisappear {
      viewStore.send(.teardown)
    }
  }
}

#Preview {
  MovieHomePage(store: .init(
    initialState: MovieHomeStore.State(),
    reducer: {
      MovieHomeStore(
        env: MovieHomeEnvMock(
          mainQueue: .main,
          useCaseGroup: MovieSideEffectGroupMock()))
    }))
}
