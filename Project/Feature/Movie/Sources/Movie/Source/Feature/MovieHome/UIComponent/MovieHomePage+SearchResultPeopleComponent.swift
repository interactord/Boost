import Foundation
import SwiftUI

// MARK: - MovieHomePage.SearchResultPeopleComponenet

extension MovieHomePage {
  struct SearchResultPeopleComponent {
    let viewState: ViewState
  }
}

// MARK: - MovieHomePage.SearchResultPeopleComponenet + View

extension MovieHomePage.SearchResultPeopleComponent: View {
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

              Text(profile.workList.map { $0 }.joined(separator: ","))
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

extension MovieHomePage.SearchResultPeopleComponent {
  struct ViewState: Equatable {
    let profileList: [ProfileItem]
  }
}

// MARK: - MovieHomePage.SearchResultPeopleComponenet.ViewState.ProfileItem

extension MovieHomePage.SearchResultPeopleComponent.ViewState {
  struct ProfileItem: Equatable, Identifiable {
    let id = UUID()
    let name: String
    let workList: [String]
  }
}
