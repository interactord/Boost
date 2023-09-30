import Domain
import Foundation
import SwiftUI

// MARK: - ReviewPage.ItemListComponent

extension ReviewPage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

// MARK: - ReviewPage.ItemListComponent + View

extension ReviewPage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewState.itemList) { item in
          ItemComponent(item: item)
        }
        .padding(.horizontal)
        .padding(.vertical)
      }
      .background(Color.white)
    }
  }
}

// MARK: - ReviewPage.ItemListComponent.ViewState

extension ReviewPage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [ReviewItem]

    init(rawValue: [MovieDetailDomain.Response.ReviewResultItem]) {
      itemList = rawValue.map(ReviewItem.init(rawValue:))
    }
  }
}

// MARK: - ReviewPage.ItemListComponent.ViewState.ReviewItem

extension ReviewPage.ItemListComponent.ViewState {
  struct ReviewItem: Equatable, Identifiable {
    let id: String // author id
    let author: String
    let content: String
    let rawValue: MovieDetailDomain.Response.ReviewResultItem

    init(rawValue: MovieDetailDomain.Response.ReviewResultItem) {
      id = rawValue.id
      author = rawValue.author
      content = rawValue.content
      self.rawValue = rawValue
    }
  }
}

// MARK: - ReviewPage.ItemListComponent.ItemComponent

extension ReviewPage.ItemListComponent {
  fileprivate struct ItemComponent {
    let item: ViewState.ReviewItem
  }
}

// MARK: - ReviewPage.ItemListComponent.ItemComponent + View

extension ReviewPage.ItemListComponent.ItemComponent: View {
  var body: some View {
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
}
