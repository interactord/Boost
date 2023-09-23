import Architecture
import ComposableArchitecture
import DesignSystem
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
    .init(rawValue: viewStore.fetchMovieCard.value)
  }

  private var listButtonComponent: ListButtonComponent.ViewState {
    .init(text: "list button")
  }

  private var movieReviewComponent: MovieReviewComponent.ViewState {
    //    .init(text: "reviews")
    .init(rawValue: viewStore.fetchMovieReview.value)
  }

  private var movieOverviewComponent: MovieOverviewComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCard.value)
  }

  private var keywordListComponent: KeywordListComponent.ViewState {
    //    .init(rawValue: viewStore.fetchMovieCard.value!.keywordBucket.keywordList)
    .init(rawValue: viewStore.fetchMovieCard.value?.keywordBucket)
  }

  private var castListComponent: CastListComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCredit.value)
  }

  private var directorComponent: DirectorComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCredit.value)
  }

  private var crewListComponent: CrewListComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCredit.value)
  }

  private var similarMovieListComponent: SimilarMovieListComponent.ViewState {
    .init(rawValue: viewStore.fetchSimilarMovie.value)
  }

  private var recomendedMovieListComponent: RecommendedMovieListComponent.ViewState {
    .init(rawValue: viewStore.fetchRecommendedMovie.value)
  }

  private var otherPosterListComponent: OtherPosterListComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCard.value?.imageBucket)
  }

  private var backdropImageListComponent: BackdropImageListComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCard.value?.imageBucket)
  }
}

extension MovieDetailPage {
  private var isLoading: Bool {
    viewStore.fetchMovieCard.isLoading
      || viewStore.fetchMovieReview.isLoading
      || viewStore.fetchMovieCredit.isLoading
  }
}

// MARK: View

extension MovieDetailPage: View {
  var body: some View {
    ScrollView {
      VStack { // moviecard ~ overview
        MovieCardComponent(viewState: movieCardComponent)

        // 리스트 버튼들
        ListButtonComponent(viewState: listButtonComponent)

        if movieReviewComponent.totalReviewList != 0 {
          Divider()
            .padding(.leading, 48)

          // 리뷰
          MovieReviewComponent(viewState: movieReviewComponent)
        }

        if !movieOverviewComponent.overView.isEmpty {
          Divider()
            .padding(.leading, 16)
          // 오버뷰
          MovieOverviewComponent(viewState: movieOverviewComponent)
        }
      }
      .background(Color.white)
      .cornerRadius(10)
      .padding(.bottom)
      .padding(.horizontal, 16)

      Spacer(minLength: 32)

      // kewyword ~
      VStack {
        Group {
          // keywordList
          if !keywordListComponent.keywordList.isEmpty {
            KeywordListComponent(viewState: keywordListComponent)
          }

          if !castListComponent.profileList.isEmpty {
            Divider()
              .padding(.leading, 16)

            // cast
            CastListComponent(viewState: castListComponent)
          }

          Divider()
            .padding(.leading, 16)

          // director
          DirectorComponent(viewState: directorComponent)

          Divider()
            .padding(.leading, 16)

          // crew
          CrewListComponent(viewState: crewListComponent)
        }

        Group {
          // similar movielist
          if !similarMovieListComponent.itemList.isEmpty {
            Divider()
              .padding(.leading, 16)

            SimilarMovieListComponent(viewState: similarMovieListComponent)
          }

          if !recomendedMovieListComponent.itemList.isEmpty {
            Divider()
              .padding(.leading, 16)

            // recommend movieList
            RecommendedMovieListComponent(viewState: recomendedMovieListComponent)
          }

          if !otherPosterListComponent.itemList.isEmpty {
            Divider()
              .padding(.leading, 16)

            // other posterList
            OtherPosterListComponent(viewState: otherPosterListComponent)
          }

          if !backdropImageListComponent.itemList.isEmpty {
            Divider()
              .padding(.leading, 16)

            // image List
            BackdropImageListComponent(viewState: backdropImageListComponent)
          }
        }
      }
      .background(Color.white)
      .cornerRadius(10)
      .padding(.horizontal, 16)
    } // scrollview
    .background(Color.customBgColor)

    .animation(.spring(), value: viewStore.state)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      viewStore.send(.getMovieDetail)
    }
    .onDisappear {
      viewStore.send(.teardown)
    }
  }
}
