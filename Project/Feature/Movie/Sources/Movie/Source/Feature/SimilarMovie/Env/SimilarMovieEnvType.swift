import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SimilarMovieEnvType

protocol SimilarMovieEnvType {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var useCaseGroup: MovieSideEffectGroup { get }

  var similarMovie: (Int)
    -> Effect<Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>> { get }
}

extension SimilarMovieEnvType {
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
}
