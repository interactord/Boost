import Architecture
import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: - ReviewPage

struct ReviewPage {

  private let store: StoreOf<ReviewStore>
  @ObservedObject private var viewStore: ViewStoreOf<ReviewStore>

  init(store: StoreOf<ReviewStore>) {
    self.store = store
    viewStore = ViewStore(store, observe: { $0 })
  }
}

extension ReviewPage {
  private var itemListComponentViewState: ItemListComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieReview.value.resultList)
  }
}

extension ReviewPage {
  private var isLoading: Bool {
    viewStore.fetchMovieReview.isLoading
  }
}

// MARK: View

extension ReviewPage: View {

  var body: some View {
    ScrollView {
      VStack {
        ItemListComponent(viewState: itemListComponentViewState)
      }
      .background(Color.white)
      .cornerRadius(10)
      .padding(.bottom)
      .padding(.horizontal, 16)
    }
    .background(Color.customBgColor)
    .onAppear {
      viewStore.send(.getMovieReview)
    }
    .onDisappear {
      viewStore.send(.teardown)
    }
  }
}

#Preview {
  ReviewPage(store: .init(
    initialState: ReviewStore.State(movieID: .zero),
    reducer: {
      ReviewStore(
        env: ReviewEnvMock(
          mainQueue: .main,
          useCaseGroup: MovieSideEffectGroupMock()))
    }))
}
