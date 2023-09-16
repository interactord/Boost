import Foundation
import SwiftUI

// MARK: - MyListsPage.CustomListsComponent

extension MyListsPage {
  struct CustomListsComponent {
    let viewState: ViewState
  }
}

// MARK: - MyListsPage.CustomListsComponent + View

extension MyListsPage.CustomListsComponent: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text("CUSTOM LISTS")
          .font(.footnote)
          .foregroundColor(Color(.gray))
          .padding(.leading, 16)

        // 나중에 Sheet로 변경 할 것
        Text(viewState.placeHolder)
          .font(.callout)
          .foregroundColor(.customGreenColor)
          .frame(minHeight: 40)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 16)
          .background(Color.white)
      }

      Spacer()
    }
  }
}

// MARK: - MyListsPage.CustomListsComponent.ViewState

extension MyListsPage.CustomListsComponent {
  struct ViewState: Equatable {
    let placeHolder: String
  }
}
