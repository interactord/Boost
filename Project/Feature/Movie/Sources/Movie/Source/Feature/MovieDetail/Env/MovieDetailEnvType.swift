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

  var movieReview: ()
    -> Effect<Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>> { get }

  var movieCredit: ()
    -> Effect<Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>> { get }

  var similarMovie: ()
    -> Effect<Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>> { get }

  var recommendedMovie: ()
    -> Effect<Result<MovieDetailDomain.Response.RecommenededMovieResult, CompositeErrorDomain>> { get }
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

  public var movieReview: ()
    -> Effect<Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>>
  {
    {
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .movieReview(.init(language: "en-US"))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

  public var movieCredit: ()
    -> Effect<Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>>
  {
    {
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .movieCredit(.init(language: "ko-US"))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

  public var similarMovie: ()
    -> Effect<Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>>
  {
    {
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .similarMovie(.init(language: "ko-us"))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

  public var recommendedMovie: ()
    -> Effect<Result<MovieDetailDomain.Response.RecommenededMovieResult, CompositeErrorDomain>>
  {
    {
      .publisher {
        useCaseGroup
          .movieDetailUseCase
          .recommendedMovie(.init(language: "ko-us"))
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }

}
