import Foundation
import LinkNavigator

// MARK: - MovieHomeLive

struct MovieHomeLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: MovieHomeEnvType

extension MovieHomeLive: MovieHomeEnvType { }
