import Foundation
import LinkNavigator

struct CrewLive {
  
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

extension CrewLive: CrewEnvType {
}
