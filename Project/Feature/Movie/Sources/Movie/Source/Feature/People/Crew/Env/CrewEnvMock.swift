import ComposableArchitecture
import Domain
import Foundation

// MARK: - CrewEnvMocck

struct CrewEnvMocck {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: CrewEnvType

extension CrewEnvMocck: CrewEnvType { }
