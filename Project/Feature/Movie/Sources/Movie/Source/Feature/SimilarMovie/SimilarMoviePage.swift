import Architecture
import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: - SimilarMoviePage

struct SimilarMoviePage {

  private let store: StoreOf<SimilarMovieStore>
  @ObservedObject private var viewStore: ViewStoreOf<SimilarMovieStore>

  init(store: StoreOf<SimilarMovieStore>) {
    self.store = store
    viewStore = ViewStore(store, observe: { $0 })
  }
}

extension SimilarMoviePage {
  private var itemListComponentViewState: ItemListComponent.ViewState {
    .init(rawValue: viewStore.fetchSimilarMovie.value.resultList)
  }
}

// MARK: View

extension SimilarMoviePage: View {
  var body: some View {
    ScrollView {
      VStack {
        Text("similarMoviePage")
        ItemListComponent(viewState: itemListComponentViewState)
      }
      .padding(.leading, 12)
    }
    .onAppear {
      viewStore.send(.getSimilarMovie)
    }
    .onDisappear {
      viewStore.send(.teardown)
    }
  }
}
