import Foundation
import LinkNavigator

// MARK: - CrewEnvLive

struct CrewEnvLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: CrewEnvType

extension CrewEnvLive: CrewEnvType { }
