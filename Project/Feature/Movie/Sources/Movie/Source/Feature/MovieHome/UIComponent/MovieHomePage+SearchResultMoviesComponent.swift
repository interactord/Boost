import Foundation
import SwiftUI

extension MovieHomePage {
  struct SearchResultMoviesComponent {
    let viewState: ViewState
  }
}

extension MovieHomePage.SearchResultMoviesComponent: View {

  var body: some View {
    Text(viewState.text)
  }
}

extension MovieHomePage.SearchResultMoviesComponent {
  struct ViewState: Equatable {
    let text: String
  }
}
