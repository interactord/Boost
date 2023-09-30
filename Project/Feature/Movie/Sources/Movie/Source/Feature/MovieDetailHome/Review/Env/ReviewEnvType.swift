import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - ReviewEnvType

protocol ReviewEnvType {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var useCaseGroup: MovieSideEffectGroup { get }

  var movieReview: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>> { get }
}

extension ReviewEnvType {
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
}
