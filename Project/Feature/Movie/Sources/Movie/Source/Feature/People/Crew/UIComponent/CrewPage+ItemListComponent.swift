import Foundation
import SwiftUI
import Domain

extension CrewPage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

extension CrewPage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        ForEach(viewState.profileList, id: \.id) { profile  in
          
          HStack(spacing: 16) {
            Asset.spongeBob.swiftUIImage
              .resizable()
              .frame(width: 70, height: 90)
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(.black, lineWidth: 1)
              )
              .padding(.top)
            
            VStack(alignment: .leading, spacing: 8) {
              
              Text(profile.name)
                .font(.headline)
                            
              Text(profile.department)
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

extension CrewPage.ItemListComponent {
  struct ViewState: Equatable {
    let profileList: [ProfileItem]
  }
}

extension CrewPage.ItemListComponent.ViewState {
  struct ProfileItem: Equatable, Identifiable {
    let id = UUID()
    let name: String
    let department: String
  }
}

