import Foundation
import LinkNavigator

// MARK: - ReviewLive

struct ReviewLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: ReviewEnvType

extension ReviewLive: ReviewEnvType { }
