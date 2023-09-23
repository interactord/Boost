import Foundation
import LinkNavigator

struct ReviewLive {
  
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

extension ReviewLive: ReviewEnvType {
}
