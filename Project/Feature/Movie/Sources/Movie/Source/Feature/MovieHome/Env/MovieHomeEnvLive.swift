import Foundation
import LinkNavigator

struct MovieHomeLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

extension MovieHomeLive: MovieHomeEnvType {
}
