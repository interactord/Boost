import Architecture
import ComposableArchitecture
import Domain
import Foundation
import LinkNavigator
import URLEncodedForm

// MARK: - MovieDetailEnvLive

struct MovieDetailEnvLive {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol

  init(
    mainQueue: AnySchedulerOf<DispatchQueue> = .main,
    useCaseGroup: MovieSideEffectGroup,
    navigator: LinkNavigatorURLEncodedItemProtocol)
  {
    self.mainQueue = mainQueue
    self.useCaseGroup = useCaseGroup
    self.navigator = navigator
  }
}

// MARK: MovieDetailEnvType

extension MovieDetailEnvLive: MovieDetailEnvType {
  var routeToReview: (MovieDetailDomain.Response.MovieReviewResult) -> Void {
    { item in
      navigator.backOrNext(
        linkItem: .init(
          path: Link.Movie.Path.review.rawValue,
          items: item.encodeString()),
        isAnimated: true)
    }
  }

  var routeToCast: (MovieDetailDomain.Response.MovieCreditResult) -> Void {
    { item in
      navigator.backOrNext(
        linkItem: .init(
          path: Link.Movie.Path.cast.rawValue,
          items: item.encodeString()),
        isAnimated: true)
    }
  }

  var routeToCrew: (MovieDetailDomain.Response.MovieCreditResult) -> Void {
    { item in
      navigator.backOrNext(
        linkItem: .init(
          path: Link.Movie.Path.crew.rawValue,
          items: item.encodeString()),
        isAnimated: true)
    }
  }

  var routeToSimilarMovie: (MovieDetailDomain.Response.SimilarMovieResult) -> Void {
    { item in
      navigator.backOrNext(
        linkItem: .init(
          path: Link.Movie.Path.similarMovie.rawValue,
          items: item.encodeString()),
        isAnimated: true)
    }
  }
}
