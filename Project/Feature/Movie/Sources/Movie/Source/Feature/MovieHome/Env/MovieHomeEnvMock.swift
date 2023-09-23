import ComposableArchitecture
import Foundation

// MARK: - MovieHomeMock

struct MovieHomeMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: MovieHomeEnvType

extension MovieHomeMock: MovieHomeEnvType { }
