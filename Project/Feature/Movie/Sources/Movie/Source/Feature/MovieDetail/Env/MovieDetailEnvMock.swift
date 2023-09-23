import ComposableArchitecture
import Foundation

// MARK: - MovieDetailMock

struct MovieDetailMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: MovieDetailEnvType

extension MovieDetailMock: MovieDetailEnvType { }
