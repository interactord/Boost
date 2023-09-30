import Architecture
import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: - CastPage

struct CastPage {

  private let store: StoreOf<CastStore>
  @ObservedObject private var viewStore: ViewStoreOf<CastStore>

  init(store: StoreOf<CastStore>) {
    self.store = store
    viewStore = ViewStore(store, observe: { $0 })
  }
}

extension CastPage {
  private var itemListComponentViewState: ItemListComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCast.value.castList)
  }
}

extension CastPage {
  private var isLoading: Bool {
    viewStore.fetchMovieCast.isLoading
  }
}

// MARK: View

extension CastPage: View {
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
      viewStore.send(.getMovieCast)
    }
    .onDisappear {
      viewStore.send(.teardown)
    }
  }
}

#Preview {
  CastPage(store: .init(
    initialState: CastStore.State(movieID: .zero),
    reducer: {
      CastStore(env: CastEnvMock(mainQueue: .main, useCaseGroup: MovieSideEffectGroupMock()))
    }))
}
