import ComposableArchitecture
import Domain
import Foundation

// MARK: - SimilarMovieEnvMock

struct SimilarMovieEnvMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: SimilarMovieEnvType

extension SimilarMovieEnvMock: SimilarMovieEnvType { }
