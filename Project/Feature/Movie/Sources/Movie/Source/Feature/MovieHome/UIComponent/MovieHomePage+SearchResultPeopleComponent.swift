import Domain
import Foundation
import SwiftUI

// MARK: - MovieHomePage.SearchResultPeopleComponenet

extension MovieHomePage {
  struct SearchResultPeopleComponenet {
    let viewState: ViewState
  }
}

// MARK: - MovieHomePage.SearchResultPeopleComponenet + View

extension MovieHomePage.SearchResultPeopleComponenet: View {
  var body: some View {
    // 검색 했을때 맞는 키워드가 없으면 keywords에는 header만 나오고, Result 부분은 "No results" 가 나오도록 해야됌 (아직 구현 x)
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(viewState.profileList) { profile in

          HStack(spacing: 16) {
            Asset.spongeBob.swiftUIImage
              .resizable()
              .frame(width: 70, height: 90)
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(.black, lineWidth: 1))

            VStack(alignment: .leading) {
              Text(profile.name)
                .font(.headline)
                .foregroundColor(.customYellowColor)
                .padding(.top, 8)

              Spacer()

              Text(profile.workList.compactMap { $0 }.joined(separator: ", "))
                .font(.subheadline)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
              Spacer()
            }

            Spacer()

            Image(systemName: "chevron.right")
              .resizable()
              .frame(width: 8, height: 12)
              .foregroundColor(Color(.gray))
              .padding(.trailing, 16)
          }
          .padding(.vertical, 16)

          Divider()
            .padding(.leading, 144)
        }
      }
    }
  }
}

// MARK: - MovieHomePage.SearchResultPeopleComponenet.ViewState

extension MovieHomePage.SearchResultPeopleComponenet {
  struct ViewState: Equatable {
    let profileList: [ProfileItem]

    init(rawValue: SearchDomain.Response.PeopleResult?) {
      profileList = (rawValue?.resultList ?? []).map(ProfileItem.init(rawValue:))
    }
  }
}

// MARK: - MovieHomePage.SearchResultPeopleComponenet.ViewState.ProfileItem

extension MovieHomePage.SearchResultPeopleComponenet.ViewState {
  struct ProfileItem: Equatable, Identifiable {
    let id: Int
    let name: String
    let workList: [String?]

    init(rawValue: SearchDomain.Response.PersonResultItem) {
      id = rawValue.id
      name = rawValue.name
      workList = rawValue.appearanceList.map { $0.title ?? $0.originalTitle }
    }
  }
}
