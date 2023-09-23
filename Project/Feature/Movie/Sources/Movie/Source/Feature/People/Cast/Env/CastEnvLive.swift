import Foundation
import LinkNavigator

// MARK: - CastLive

struct CastLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: CastEnvType

extension CastLive: CastEnvType { }
