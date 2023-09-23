import Foundation
import Architecture
import SwiftUI
import ComposableArchitecture

struct CrewPage {
  
  private let store: StoreOf<CrewStore>
  @ObservedObject private var viewStore: ViewStoreOf<CrewStore>
  
  init(store: StoreOf<CrewStore>) {
    self.store = store
    self.viewStore = ViewStore(store, observe: { $0 })
  }
}

extension CrewPage {
  private var itemListComponentViewState: ItemListComponent.ViewState {
    .init(
      profileList: [
      ItemListComponent.ViewState.ProfileItem(
        name: "Rodrigo Prieto",
        department: "Camera"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Noa Baumbach",
        department: "Production"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Carmel Jackson",
        department: "Costume & Make-Up"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Toby Emmerich",
        department: "Production"),
      ItemListComponent.ViewState.ProfileItem(
        name: "David Heyman",
        department: "Production"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Andy Malcolm",
        department: "Sound"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Lucy Bevan",
        department: "Production"),
      ItemListComponent.ViewState.ProfileItem(
        name: "Roy Taylor",
        department: "Crew")
      ])
  }
}


extension CrewPage: View {
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

