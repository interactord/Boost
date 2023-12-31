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
    .init(rawValue: viewStore.fetchMovieCard.value.item)
  }

  private var keywordListComponent: KeywordListComponent.ViewState {
    //    .init(rawValue: viewStore.fetchMovieCard.value!.keywordBucket.keywordList)
    .init(rawValue: viewStore.fetchMovieCard.value.item.keywordBucket)
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
    .init(rawValue: viewStore.fetchMovieCard.value.item.imageBucket)
  }

  private var backdropImageListComponent: BackdropImageListComponent.ViewState {
    .init(rawValue: viewStore.fetchMovieCard.value.item.imageBucket)
  }
}

extension MovieDetailPage {
  private var isLoading: Bool {
    viewStore.fetchMovieCard.isLoading
      || viewStore.fetchMovieReview.isLoading
      || viewStore.fetchMovieCredit.isLoading
      || viewStore.fetchSimilarMovie.isLoading
      || viewStore.fetchRecommendedMovie.isLoading
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

        if movieReviewComponent.rawValue.totalResult != .zero {
          Divider()
            .padding(.leading, 48)

          // 리뷰
          MovieReviewComponent(
            viewState: movieReviewComponent,
            selectAction: { viewStore.send(.onSelectReview($0)) })
        }

        if !movieOverviewComponent.overView.isEmpty {
          Divider()
            .padding(.leading, 16)
          // 오버뷰
          MovieOverviewComponent(viewState: movieOverviewComponent)
        }
      }
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

          if !castListComponent.itemList.isEmpty {
            Divider()
              .padding(.leading, 16)

            // cast
            CastListComponent(
              viewState: castListComponent,
              selectAction: {
                viewStore.send(.onSelectCast($0))
              })
          }

          if !directorComponent.director.isEmpty {
            Divider()
              .padding(.leading, 16)

            // director
            DirectorComponent(viewState: directorComponent)
          }

          if !crewListComponent.itemList.isEmpty {
            Divider()
              .padding(.leading, 16)

            // crew
            CrewListComponent(
              viewState: crewListComponent,
              selectAction: { viewStore.send(.onSelectCrew($0)) })
          }
        }

        Group {
          // similar movielist
          if !similarMovieListComponent.itemList.isEmpty {
            Divider()
              .padding(.leading, 16)

            SimilarMovieListComponent(
              viewState: similarMovieListComponent,
              selectAction: { viewStore.send(.onSelectSimilarMovie($0)) })
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
    .navigationTitle(viewStore.fetchMovieCard.value.item.title)

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

#Preview {
  MovieDetailPage(
    store: .init(
      initialState: MovieDetailStore.State(movieID: .zero),
      reducer: {
        MovieDetailStore(
          env: MovieDetailEnvMock(
            mainQueue: .main,
            useCaseGroup: MovieSideEffectGroupMock()))
      }))
}
