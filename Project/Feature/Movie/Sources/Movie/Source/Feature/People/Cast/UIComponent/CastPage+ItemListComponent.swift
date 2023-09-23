import Domain
import Foundation
import SwiftUI

// MARK: - CastPage.ItemListComponent

extension CastPage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

// MARK: - CastPage.ItemListComponent + View

extension CastPage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(viewState.profileList, id: \.id) { profile in

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
              Text(profile.name)
                .font(.headline)

              Text(profile.character)
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
        .padding(.horizontal, 16)
      }
    }
  }
}

// MARK: - CastPage.ItemListComponent.ViewState

extension CastPage.ItemListComponent {
  struct ViewState: Equatable {
    let profileList: [ProfileItem]
  }
}

// MARK: - CastPage.ItemListComponent.ViewState.ProfileItem

extension CastPage.ItemListComponent.ViewState {
  struct ProfileItem: Equatable, Identifiable {
    let id = UUID()
    let name: String
    let character: String
  }
}
