import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.CastListComponent

extension MovieDetailPage {
  struct CastListComponent {
    let viewState: ViewState
    let selectAction: (MovieDetailDomain.Response.MovieCreditResult) -> Void
  }
}

extension MovieDetailPage.CastListComponent {
  private var filterItemList: [ViewState.CastItem] {
    viewState.itemList.reduce(into: [ViewState.CastItem]()) { curr, next in
      if !curr.contains(where: { $0.id == next.id }) {
        curr.append(next)
      }
    }
  }
}

// MARK: - MovieDetailPage.CastListComponent + View

extension MovieDetailPage.CastListComponent: View {
  var body: some View {
    VStack {
      HStack {
        Text("Cast")
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
        print("Tapped Cast See all")
      }

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          ForEach(filterItemList) { item in
            ItemComponent(item: item)
              .background(.white)
          }
        }
      }
    }
    .padding(.vertical)
    .padding(.horizontal, 16)
  }
}

// MARK: - MovieDetailPage.CastListComponent.ViewState

extension MovieDetailPage.CastListComponent {
  struct ViewState: Equatable {
    let itemList: [CastItem] //
    let rawValue: MovieDetailDomain.Response.MovieCreditResult

    init(rawValue: MovieDetailDomain.Response.MovieCreditResult?) {
      itemList = (rawValue?.castList ?? []).map(CastItem.init(rawValue:))
      self.rawValue = rawValue ?? MovieDetailDomain.Response.MovieCreditResult()
    }
  }
}

// MARK: - MovieDetailPage.CastListComponent.ViewState.CastItem

extension MovieDetailPage.CastListComponent.ViewState {
  struct CastItem: Equatable, Identifiable {
    let id: Int // cast id
    let name: String
    let character: String
    let profileImage: String

    init(rawValue: MovieDetailDomain.Response.CastResultItem) {
      id = rawValue.id
      name = rawValue.name
      character = rawValue.character
      profileImage = rawValue.profileImage ?? ""
    }
  }
}

// MARK: - MovieDetailPage.CastListComponent.ItemComponent

extension MovieDetailPage.CastListComponent {
  fileprivate struct ItemComponent {
    let item: ViewState.CastItem
  }
}

// MARK: - MovieDetailPage.CastListComponent.ItemComponent + View

extension MovieDetailPage.CastListComponent.ItemComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .center) {
        // API로 받아오는 데이터가 nil이 아니라 ""(빈문자열)로 표시 될수 있으므로 != nil 대신 이런 방식으로 사용
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
        Text(item.character)
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
    .frame(width: 90)
    .lineLimit(0)
  }
}
