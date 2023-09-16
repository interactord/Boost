import Foundation
import SwiftUI

// MARK: - MovieDetailPage.MovieOverviewComponent

extension MovieDetailPage {
  struct MovieOverviewComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.MovieOverviewComponent { }

// MARK: - MovieDetailPage.MovieOverviewComponent + View

extension MovieDetailPage.MovieOverviewComponent: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text(viewState.text)
    }
  }
}

// MARK: - MovieDetailPage.MovieOverviewComponent.ViewState

extension MovieDetailPage.MovieOverviewComponent {
  struct ViewState: Equatable {
    let text: String
  }
}
