import Foundation
import SwiftUI

extension ReviewPage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

extension ReviewPage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewState.itemList, id: \.content) { item in
          VStack(alignment: .leading, spacing: 8) {
            Text("Review written by \(item.author)")
              .font(.headline)
            
            Text(item.content)
              .font(.callout)
            
            Divider()
              .padding(.top, 16)
              .padding(.leading, 16)
          }
        }
        .padding(.horizontal)
        .padding(.vertical)
      }
      .background(Color.white)      
    }
  }
}

extension ReviewPage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [ReviewItem]
  }
}

extension ReviewPage.ItemListComponent.ViewState {
  struct ReviewItem: Equatable {
    let author: String
    let content: String
  }
}
