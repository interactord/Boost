import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - MovieDetailEnvType

protocol MovieDetailEnvType {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var useCaseGroup: MovieSideEffectGroup { get }

  var movieCard: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieCardResult, CompositeErrorDomain>> { get }

  var movieReview: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>> { get }

  var movieCredit: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>> { get }

  var similarMovie: (Int)
    -> Effect<Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>> { get }

  var recommendedMovie: (Int)
    -> Effect<Result<MovieDetailDomain.Response.RecommenededMovieResult, CompositeErrorDomain>> { get }

  var routeToReview: (MovieDetailDomain.Response.MovieReviewResult) -> Void { get }

  var routeToCast: (MovieDetailDomain.Response.MovieCreditResult) -> Void { get }

  var routeToCrew: (MovieDetailDomain.Response.MovieCreditResult) -> Void { get }

  var routeToSimilarMovie: (MovieDetailDomain.Response.SimilarMovieResult) -> Void { get }
}

extension MovieDetailEnvType {
  public var movieCard: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieCardResult, CompositeErrorDomain>>
  {
    { id in
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .movieCard(.init(id: id))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

  public var movieReview: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>>
  {
    { id in
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .movieReview(.init(id: id))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

  public var movieCredit: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>>
  {
    { id in
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .movieCredit(.init(id: id))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

  public var similarMovie: (Int)
    -> Effect<Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>>
  {
    { id in
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .similarMovie(.init(id: id))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

  public var recommendedMovie: (Int)
    -> Effect<Result<MovieDetailDomain.Response.RecommenededMovieResult, CompositeErrorDomain>>
  {
    { id in
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .recommendedMovie(.init(id: id))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

}
