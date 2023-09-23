import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.CastListComponent

extension MovieDetailPage {
  struct CastListComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.CastListComponent { }

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

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          ForEach(viewState.profileList, id: \.id) { profile in
            Button(action: { }) {
              VStack(alignment: .center) {
                // API로 받아오는 데이터가 nil이 아니라 ""(빈문자열)로 표시 될수 있으므로 != nil 대신 이런 방식으로 사용
                if !profile.profileImage.isEmpty {
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

                Text(profile.name)
                  .font(.footnote)
                  .foregroundColor(Color(.label))
                Text(profile.character)
                  .font(.caption)
                  .foregroundColor(.gray)
              }
            }
            .frame(width: 90)
            .lineLimit(0)
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
    let profileList: [ProfileItem]

    init(rawValue: MovieDetailDomain.Response.MovieCreditResult?) {
      profileList = (rawValue?.castList ?? []).map(ProfileItem.init(rawValue:))
    }
  }
}

// MARK: - MovieDetailPage.CastListComponent.ViewState.ProfileItem

extension MovieDetailPage.CastListComponent.ViewState {
  struct ProfileItem: Equatable, Identifiable {
    let id: Int
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
