import Foundation
import Domain
import ComposableArchitecture
import Architecture

protocol MovieDetailEnvType {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var useCaseGroup: MovieSideEffectGroup { get }
  
  var movieCard: ()
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
  public var movieCard: ()
  -> Effect<Result<MovieDetailDomain.Response.MovieCardResult, CompositeErrorDomain>> {
    {
        .publisher {
          useCaseGroup
            .movieDetailUseCase
            .movieCard(.init(language: "ko-kr", appendToResponse: "keywords,images", includeImageLanguage: "ko,en,null"))
            .mapToResult()
            .receive(on: mainQueue)
        }
    }
  }
  
  public var movieReview: ()
  -> Effect<Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>> {
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
  -> Effect<Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>> {
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
  -> Effect<Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>> {
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
  -> Effect<Result<MovieDetailDomain.Response.RecommenededMovieResult, CompositeErrorDomain>> {
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

