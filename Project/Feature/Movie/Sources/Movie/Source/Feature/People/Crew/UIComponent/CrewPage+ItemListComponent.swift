import Domain
import Foundation
import SwiftUI

// MARK: - CrewPage.ItemListComponent

extension CrewPage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

extension CrewPage.ItemListComponent {
  private var filterItemList: [ViewState.CrewItem] {
    viewState.itemList.reduce(into: [ViewState.CrewItem]()) { curr, next in
      if !curr.contains(where: { $0.id == next.id }) {
        curr.append(next)
      }
    }
  }
}

// MARK: - CrewPage.ItemListComponent + View

extension CrewPage.ItemListComponent: View {
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

// MARK: - CrewPage.ItemListComponent.ViewState

extension CrewPage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [CrewItem]

    init(rawValue: [MovieDetailDomain.Response.CrewResultItem]) {
      itemList = rawValue.map(CrewItem.init(rawValue:))
    }
  }
}

// MARK: - CrewPage.ItemListComponent.ViewState.CrewItem

extension CrewPage.ItemListComponent.ViewState {
  struct CrewItem: Equatable, Identifiable {
    let id: Int // 각 cast의 id
    let name: String
    let department: String
    let rawValue: MovieDetailDomain.Response.CrewResultItem

    init(rawValue: MovieDetailDomain.Response.CrewResultItem) {
      id = rawValue.id
      name = rawValue.name
      department = rawValue.department
      self.rawValue = rawValue
    }
  }
}

// MARK: - CrewPage.ItemListComponent.ItemComponent

extension CrewPage.ItemListComponent {
  fileprivate struct ItemComponent {
    let item: ViewState.CrewItem
  }
}

// MARK: - CrewPage.ItemListComponent.ItemComponent + View

extension CrewPage.ItemListComponent.ItemComponent: View {
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

        Text(item.department)
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
