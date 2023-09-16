import Foundation
import SwiftUI

// MARK: - MovieDetailPage.MovieReviewComponent

extension MovieDetailPage {
  struct MovieReviewComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.MovieReviewComponent { }

// MARK: - MovieDetailPage.MovieReviewComponent + View

extension MovieDetailPage.MovieReviewComponent: View {
  var body: some View {
    HStack {
      Text(viewState.text)
      Spacer()
      Image(systemName: "chevron.right")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 10, height: 10)
    }
  }
}

// MARK: - MovieDetailPage.MovieReviewComponent.ViewState

extension MovieDetailPage.MovieReviewComponent {
  struct ViewState: Equatable {
    let text: String
  }
}
