import Foundation
import LinkNavigator

// MARK: - ReviewEnvLive

struct ReviewEnvLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: ReviewEnvType

extension ReviewEnvLive: ReviewEnvType { }
