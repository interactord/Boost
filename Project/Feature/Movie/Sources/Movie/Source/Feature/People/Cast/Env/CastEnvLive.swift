import Foundation
import LinkNavigator

// MARK: - CastEnvLive

struct CastEnvLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: CastEnvType

extension CastEnvLive: CastEnvType { }
