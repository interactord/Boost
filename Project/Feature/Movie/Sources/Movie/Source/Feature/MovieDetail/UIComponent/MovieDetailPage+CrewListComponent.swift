import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.CrewListComponent

extension MovieDetailPage {
  struct CrewListComponent {
    let viewState: ViewState
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

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          ForEach(viewState.profileList, id: \.id) { profile in
            Button(action: { }) {
              VStack(alignment: .center) {
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
                Text(profile.department)
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

// MARK: - MovieDetailPage.CrewListComponent.ViewState

extension MovieDetailPage.CrewListComponent {
  struct ViewState: Equatable {
    let profileList: [ProfileItem]

    init(rawValue: MovieDetailDomain.Response.MovieCreditResult?) {
      profileList = (rawValue?.crewList ?? []).map(ProfileItem.init(rawValue:))
    }
  }
}

// MARK: - MovieDetailPage.CrewListComponent.ViewState.ProfileItem

extension MovieDetailPage.CrewListComponent.ViewState {
  struct ProfileItem: Equatable, Identifiable, Hashable {
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
