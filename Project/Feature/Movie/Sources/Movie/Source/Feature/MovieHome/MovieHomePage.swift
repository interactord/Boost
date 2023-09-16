import Architecture
import ComposableArchitecture
import Foundation
import SwiftUI
import DesignSystem

// MARK: - MovieHomePage

struct MovieHomePage {

  private let store: StoreOf<MovieHomeStore>
  @ObservedObject private var viewStore: ViewStoreOf<MovieHomeStore>

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
//    .init(
//      itemList: [
//        SearchResultMoviesComponenet.ViewState.MovieItem(
//          title: "메가로돈 2",
//          voteAverage: 0.70,
//          releaseDate: "8/2/23",
//          overView: "전 세계에서 가장 깊은 마리아나 해구, 역사상 가장 거대하고 무자비한 포식자가 도사리는 그곳에서 강철 다이버 '조나스'(제이슨 스타뎀)가 더 맹렬하게 돌아온 메가 로돈'과 짜릿한 대결을 펼치는 액션 어드벤처"),
//
//        SearchResultMoviesComponenet.ViewState.MovieItem(
//          title: "더넌 2",
//          voteAverage: 0.67,
//          releaseDate: "9/6/23",
//          overView: "1956년, 프랑스의 한 성당에서 신부가 끔찍하게 살해당한다. 이 사건을 조사하기 위해 파견된 아이린 수녀는 4년 전 자신을 공포에 떨게 했던 악마의 기운을 느낀다. 어두은 밤, 계속해서 일어나는 의문의 사건들 가운데 충격적인 진실이 드러나는데..."),
//
//        SearchResultMoviesComponenet.ViewState.MovieItem(
//          title: "스트레이즈",
//          voteAverage: 0.74,
//          releaseDate: "8/18/23",
//          overView: ""),
//
//        SearchResultMoviesComponenet.ViewState.MovieItem(
//          title: "데메테르호의 마지막 항해",
//          voteAverage: 0.73,
//          releaseDate: "8/9/23",
//          overView: "브램 스토커의 소설인 <드라큘라> 중 한 에피소드를 영화화하는 작품으로 드라큘라의 관을 싣고 가던 영국 배의 선원들이 차례로 사라지는 공포스러운 상황에 관한 이야기"),
//      ],
//      keywordList: [
//        "keyword Mock1",
//        "keyword Mock2",
//        "keyword Mock3",
//      ]
//    )
    .init(itemList: [], keywordList: [])
  }

  private var searchResultPeopleComponentViewState: SearchResultPeopleComponent.ViewState {
//    .init(text: "SearchResultPeopleComponent")
    .init(
      profileList: [
        SearchResultPeopleComponent.ViewState.ProfileItem(
          name: "Florence Pugh",
          workList: ["Midsommar", "Black Wido", "Little Women"]),
        SearchResultPeopleComponent.ViewState.ProfileItem(
          name: "Morgan Freeman",
          workList: ["Se7en", "The Shawshank Redemption", "Lucy"]),
        SearchResultPeopleComponent.ViewState.ProfileItem(
          name: "Rebecca Ferguson",
          workList: ["Dune", "The Girl on the Train", "Life"]),
        SearchResultPeopleComponent.ViewState.ProfileItem(
          name: "Travis Fimmel",
          workList: ["Warcraft", "Danger Close: The Battle of Long Tan"]),
        SearchResultPeopleComponent.ViewState.ProfileItem(
          name: "Dakota Fanning",
          workList: ["Coraline", "War of the Worlds", "Man on Fire"]),
      ])
  }
}

// MARK: View

extension MovieHomePage {
  private var isLoading: Bool {
    viewStore.fetchNowPlaying.isLoading
  }
}

extension MovieHomePage: View {

  var body: some View {
    VStack {
      // 서치뷰
      SearchComponent(
        viewState: searchComponentViewState,
        keyword: viewStore.$keyword,
        throttleAction: { viewStore.send(.onUpdateKeyword) },
        clearAction: { viewStore.send(.onClearKeyword)
        })
        .padding(.trailing, 16)
        .padding(.bottom, 8)

      Divider()

      if viewStore.keyword.isEmpty {
        // 아이템 리스트
        ItemListComponent(
          viewState: itemListComponentViewState,
          nextPageAction: { viewStore.send(.getNowPlay) })
      } else {
        Group {
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
            SearchResultPeopleComponent(
              viewState: searchResultPeopleComponentViewState)
          }
        }
      }
      Spacer()
    }
    .padding(.leading, 16)
    .navigationTitle("Now Playing")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: { }) {
          Image(systemName: "gearshape")
            .resizable()
            .foregroundColor(.customYellowColor)
        }
      }
    }
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      viewStore.send(.getNowPlay)
    }
    .onDisappear {
      viewStore.send(.teardown)
    }
  }
}
