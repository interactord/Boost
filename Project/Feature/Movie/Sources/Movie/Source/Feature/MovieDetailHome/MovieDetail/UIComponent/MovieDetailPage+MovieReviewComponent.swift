import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.MovieReviewComponent

extension MovieDetailPage {
  struct MovieReviewComponent {
    let viewState: ViewState
    let selectAction: (MovieDetailDomain.Response.MovieReviewResult) -> Void
  }
}

extension MovieDetailPage.MovieReviewComponent { }

// MARK: - MovieDetailPage.MovieReviewComponent + View

extension MovieDetailPage.MovieReviewComponent: View {
  var body: some View {
    HStack {
      Text("\(viewState.rawValue.totalResult) reviews")
        .foregroundColor(.customGreenColor)

      Spacer()

      Image(systemName: "chevron.right")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 10, height: 10)
    }
    .background(.white)
    .padding(.horizontal, 16)
    .onTapGesture {
      selectAction(viewState.rawValue)
      print(viewState.rawValue.id)
      print("Tapped")
    }
  }
}

// MARK: - MovieDetailPage.MovieReviewComponent.ViewState

extension MovieDetailPage.MovieReviewComponent {
  struct ViewState: Equatable {
    let rawValue: MovieDetailDomain.Response.MovieReviewResult

    init(rawValue: MovieDetailDomain.Response.MovieReviewResult?) {
      self.rawValue = rawValue ?? MovieDetailDomain.Response.MovieReviewResult()
    }
  }
}
