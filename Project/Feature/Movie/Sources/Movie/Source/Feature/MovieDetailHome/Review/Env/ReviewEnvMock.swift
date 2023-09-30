import ComposableArchitecture
import Domain
import Foundation

// MARK: - ReviewEnvMock

struct ReviewEnvMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: ReviewEnvType

extension ReviewEnvMock: ReviewEnvType { }
