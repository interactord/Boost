import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CrewEnvType

protocol CrewEnvType {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var useCaseGroup: MovieSideEffectGroup { get }

  var movieCredit: (Int)
    -> Effect<Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>> { get }
}

extension CrewEnvType {
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
}
