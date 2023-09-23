import Foundation
import ComposableArchitecture

struct MovieDetailMock {
  
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

extension MovieDetailMock: MovieDetailEnvType {
}
