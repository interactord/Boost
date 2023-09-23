import ComposableArchitecture
import Foundation

// MARK: - MovieDetailEnvMock

struct MovieDetailEnvMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: MovieDetailEnvType

extension MovieDetailEnvMock: MovieDetailEnvType { }
