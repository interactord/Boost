import Foundation
import SwiftUI

extension MovieHomePage {
  struct SearchResultPeopleComponent {
    let viewState: ViewState
  }
}

extension MovieHomePage.SearchResultPeopleComponent: View {

  var body: some View {
    Text(viewState.text)
  }
}

extension MovieHomePage.SearchResultPeopleComponent {
  struct ViewState: Equatable {
    let text: String
  }
}
