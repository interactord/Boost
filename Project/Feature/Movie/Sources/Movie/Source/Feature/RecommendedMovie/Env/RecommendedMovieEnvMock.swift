import ComposableArchitecture
import Domain
import Foundation

// MARK: - RecommendedMovieEnvMock

struct RecommendedMovieEnvMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: RecommendedMovieEnvType

extension RecommendedMovieEnvMock: RecommendedMovieEnvType { }
