import Foundation
import ComposableArchitecture

struct MovieHomeMock {
  
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

extension MovieHomeMock: MovieHomeEnvType {
}
