import Foundation
import LinkNavigator

// MARK: - CrewLive

struct CrewLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: CrewEnvType

extension CrewLive: CrewEnvType { }
