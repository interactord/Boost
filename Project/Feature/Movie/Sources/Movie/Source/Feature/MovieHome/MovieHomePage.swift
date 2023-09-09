import Foundation
import SwiftUI
import ComposableArchitecture

struct MovieHomePage {

  private let store: StoreOf<MovieHomeStore>
  @ObservedObject private var viewStore: ViewStoreOf<MovieHomeStore>

  init(store: StoreOf<MovieHomeStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }

}

extension MovieHomePage {
  private var searchComponentViewState: SearchComponent.ViewState {
    .init(placeHolder: "Search any Movies or Person")
  }

  private var itemListComponentViewState: ItemListComponent.ViewState {
    let dummy = Array(repeating: "Dummy", count: 10).map { "\($0) \(UUID().uuidString)" }
    return .init(itemList: dummy)
  }

  private var searchResultMoviesComponentViewState: SearchResultMoviesComponent.ViewState {
    .init(text: "searchResultMoviesComponentViewState")
  }

  private var searchResultPeopleComponentViewState: SearchResultPeopleComponent.ViewState {
    .init(text: "SearchResultPeopleComponent")
  }
}

extension MovieHomePage: View {
  var body: some View {
    VStack(spacing: 16) {
      SearchComponent(
        viewState: searchComponentViewState,
        keyword: viewStore.$keyword,
        throttleAction: { viewStore.send(.onUpdateKeyword) },
        clearAction: { viewStore.send(.onClearKeyword) })
      .padding(.trailing, 16)

      Divider()

      if viewStore.keyword.isEmpty {
        ItemListComponent(
          viewState: itemListComponentViewState)
      } else {
        Group {
          Picker("", selection: viewStore.$searchFocus, content: {
            Text("Movies").tag(MovieHomeStore.State.SearchType.movies)
            Text("People").tag(MovieHomeStore.State.SearchType.people)
          })
          .pickerStyle(SegmentedPickerStyle())

          switch viewStore.searchFocus {
          case .movies:
            SearchResultMoviesComponent(
              viewState: searchResultMoviesComponentViewState)
          case .people:
            SearchResultPeopleComponent(
              viewState: searchResultPeopleComponentViewState)
          }
        }
        .padding(.trailing, 16)
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
        }
      }
    }
  }
}


