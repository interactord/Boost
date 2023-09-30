import Domain
import Foundation
import SwiftUI

// MARK: - CastPage.ItemListComponent

extension CastPage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

extension CastPage.ItemListComponent {
  private var filterItemList: [ViewState.CastItem] {
    viewState.itemList.reduce(into: [ViewState.CastItem]()) { curr, next in
      if !curr.contains(where: { $0.id == next.id }) {
        curr.append(next)
      }
    }
  }
}

// MARK: - CastPage.ItemListComponent + View

extension CastPage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(filterItemList) { item in
          ItemComponent(item: item)
        }
        .padding(.horizontal, 16)
      }
      .background(.white)
    }
  }
}

// MARK: - CastPage.ItemListComponent.ViewState

extension CastPage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [CastItem]

    init(rawValue: [MovieDetailDomain.Response.CastResultItem]) {
      itemList = rawValue.map(CastItem.init(rawValue:))
    }
  }
}

// MARK: - CastPage.ItemListComponent.ViewState.CastItem

extension CastPage.ItemListComponent.ViewState {
  struct CastItem: Equatable, Identifiable {
    let id: Int // 각 cast의 id
    let name: String
    let character: String
    let rawValue: MovieDetailDomain.Response.CastResultItem

    init(rawValue: MovieDetailDomain.Response.CastResultItem) {
      id = rawValue.id
      name = rawValue.name
      character = rawValue.character
      self.rawValue = rawValue
    }
  }
}

// MARK: - CastPage.ItemListComponent.ItemComponent

extension CastPage.ItemListComponent {
  fileprivate struct ItemComponent {
    let item: ViewState.CastItem
  }
}

// MARK: - CastPage.ItemListComponent.ItemComponent + View

extension CastPage.ItemListComponent.ItemComponent: View {
  var body: some View {
    HStack(spacing: 16) {
      Asset.spongeBob.swiftUIImage
        .resizable()
        .frame(width: 70, height: 90)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 1))
        .padding(.top)

      VStack(alignment: .leading, spacing: 8) {
        Text(item.name)
          .font(.headline)

        Text(item.character)
          .font(.subheadline)
          .foregroundColor(Color.gray)
      }

      Spacer()

      Image(systemName: "chevron.right")
        .resizable()
        .frame(width: 8, height: 12)
        .foregroundColor(Color(.gray))
    }

    Divider()
      .padding(.leading, 64)
  }
}
