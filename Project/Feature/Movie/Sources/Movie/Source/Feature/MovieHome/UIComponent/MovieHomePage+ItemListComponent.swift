import Foundation
import SwiftUI

extension MovieHomePage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

extension MovieHomePage.ItemListComponent: View {

  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewState.itemList, id: \.self) { item in
          Text(item)
        }
      }
    }
  }
}

extension MovieHomePage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [String]
  }
}
