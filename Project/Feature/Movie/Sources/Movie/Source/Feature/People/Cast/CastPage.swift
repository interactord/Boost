import Foundation
import Architecture
import SwiftUI
import ComposableArchitecture

struct CastPage {
  
  private let store: StoreOf<CastStore>
  @ObservedObject private var viewStore: ViewStoreOf<CastStore>
  
  init(store: StoreOf<CastStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
}

extension CastPage {
  private var itemListComponentViewState: ItemListComponent.ViewState {
    .init(
      profileList: [
      ItemListComponent.ViewState.ProfileItem(
        name: "Ann Roth",
        character: "The Woman on the Beanch"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Helen Mirren",
        character: "Narrator (voice)"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Will Ferrell",
        character: "Mattel CEO"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Rhea Perlman",
        character: "Ruth Handler"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Ryan Gosling",
        character: "Ken"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Michael Cera",
        character: "Allan"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Rob Brydon",
        character: "Sugar Daddy Ken"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Carlos Jacott",
        character: "Policeman")
      
      ])
  }
}


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

  }
}
