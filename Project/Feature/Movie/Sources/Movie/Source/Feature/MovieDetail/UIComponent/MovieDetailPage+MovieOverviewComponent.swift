import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.MovieOverviewComponent

extension MovieDetailPage {
  struct MovieOverviewComponent {
    let viewState: ViewState
    @State private var isOverview = false
  }
}

extension MovieDetailPage.MovieOverviewComponent {
  private var overView: String {
    viewState.overView
  }

  private var toggleText: String {
    isOverview ? "Less" : "Read More"
  }
}

// MARK: - MovieDetailPage.MovieOverviewComponent + View

extension MovieDetailPage.MovieOverviewComponent: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text("OverView:")

      Text(overView)
        .font(.subheadline)
        .foregroundColor(.gray)
        .multilineTextAlignment(.leading)
        .lineLimit(isOverview ? .max : 3)

      Button(action: { isOverview.toggle() }) {
        Text(toggleText)
          .foregroundColor(.customGreenColor)
      }
    }
    .padding(.horizontal, 12)
  }
}

// MARK: - MovieDetailPage.MovieOverviewComponent.ViewState

extension MovieDetailPage.MovieOverviewComponent {
  struct ViewState: Equatable {
    let overView: String

    init(rawValue: MovieDetailDomain.Response.MovieCardResult?) {
      overView = rawValue?.overview ?? ""
    }
  }
}
