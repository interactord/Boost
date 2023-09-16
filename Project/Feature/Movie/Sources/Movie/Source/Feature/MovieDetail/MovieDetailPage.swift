import Architecture
import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: - MovieDetailPage

struct MovieDetailPage {

  private let store: StoreOf<MovieDetailStore>
  @ObservedObject private var viewStore: ViewStoreOf<MovieDetailStore>

  init(store: StoreOf<MovieDetailStore>) {
    self.store = store
    viewStore = ViewStore(store, observe: { $0 })
  }
}

extension MovieDetailPage {
  private var movieCardComponent: MovieCardComponent.ViewState {
    .init(
      movieCard: MovieCardComponent.ViewState.MovieItem(
        releaseDate: "2023",
        runningTime: 116,
        releasedCountry: "China",
        voteAverage: 0.69,
        voteCounts: 1726,
        genreList: ["액션", "SF", "공포 "]))
  }

  private var listButtonComponent: ListButtonComponent.ViewState {
    .init(text: "list button")
  }

  private var movieReviewComponent: MovieReviewComponent.ViewState {
    .init(text: "review")
  }

  private var movieOverviewComponent: MovieOverviewComponent.ViewState {
    .init(text: "overview")
  }
}

// MARK: View

extension MovieDetailPage: View {
  var body: some View {
    ScrollView {
      VStack {
        Group {
          VStack {
            MovieCardComponent(viewState: movieCardComponent)

            // 리스트 버튼들
            ListButtonComponent(viewState: listButtonComponent)

            Divider()
              .padding(.leading, 64)

            // 리뷰
            MovieReviewComponent(viewState: movieReviewComponent)

            // 오버뷰
            MovieOverviewComponent(viewState: movieOverviewComponent)
          }
          .background(Color.white)
          .cornerRadius(10)
          .padding(.horizontal, 16)
        }
      }
    }
    .background(Color.customBgColor)
  }
}
