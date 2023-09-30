import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.CrewListComponent

extension MovieDetailPage {
  struct CrewListComponent {
    let viewState: ViewState
    let selectAction: (MovieDetailDomain.Response.MovieCreditResult) -> Void
  }
}

extension MovieDetailPage.CrewListComponent {
  private var filterItemList: [ViewState.CrewItem] {
    viewState.itemList.reduce(into: [ViewState.CrewItem]()) { curr, next in
      if !curr.contains(where: { $0.id == next.id }) {
        curr.append(next)
      }
    }
  }
}

// MARK: - MovieDetailPage.CrewListComponent + View

extension MovieDetailPage.CrewListComponent: View {
  var body: some View {
    VStack {
      HStack {
        Text("Crew")
        Text("See all")
          .foregroundColor(.customGreenColor)

        Spacer()

        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 10)
      }
      .background(.white)
      .onTapGesture {
        selectAction(viewState.rawValue)
        print("Tapped Crew See all")
      }

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          ForEach(filterItemList) { item in
            ItemComponent(item: item)
          }
        }
      }
    }
    .padding(.vertical)
    .padding(.horizontal, 16)
  }
}

// MARK: - MovieDetailPage.CrewListComponent.ViewState

extension MovieDetailPage.CrewListComponent {
  struct ViewState: Equatable {
    let itemList: [CrewItem]
    let rawValue: MovieDetailDomain.Response.MovieCreditResult

    init(rawValue: MovieDetailDomain.Response.MovieCreditResult?) {
      itemList = (rawValue?.crewList ?? []).map(CrewItem.init(rawValue:))
      self.rawValue = rawValue ?? MovieDetailDomain.Response.MovieCreditResult()
    }
  }
}

// MARK: - MovieDetailPage.CrewListComponent.ViewState.CrewItem

extension MovieDetailPage.CrewListComponent.ViewState {
  struct CrewItem: Equatable, Identifiable, Hashable {
    let id: Int
    let name: String
    let department: String
    let profileImage: String

    init(rawValue: MovieDetailDomain.Response.CrewResultItem) {
      id = rawValue.id
      name = rawValue.name
      department = rawValue.department
      profileImage = rawValue.profileImage ?? ""
    }
  }
}

// MARK: - MovieDetailPage.CrewListComponent.ItemComponent

extension MovieDetailPage.CrewListComponent {
  fileprivate struct ItemComponent {
    let item: ViewState.CrewItem
  }
}

// MARK: - MovieDetailPage.CrewListComponent.ItemComponent + View

extension MovieDetailPage.CrewListComponent.ItemComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .center) {
        if !item.profileImage.isEmpty {
          Asset.spongeBob.swiftUIImage
            .resizable()
            .frame(width: 70, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1))
        } else {
          RoundedRectangle(cornerRadius: 10)
            .fill(Color.customBgColor)
            .frame(width: 70, height: 90)
        }

        Text(item.name)
          .font(.footnote)
          .foregroundColor(Color(.label))
        Text(item.department)
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
    .frame(width: 90)
    .lineLimit(0)
  }
}
