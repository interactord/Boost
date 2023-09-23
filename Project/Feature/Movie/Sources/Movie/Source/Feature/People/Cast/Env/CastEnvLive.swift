import Foundation
import LinkNavigator

struct CastLive {
  
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

extension CastLive: CastEnvType {
}
