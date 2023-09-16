import Foundation
import LinkNavigator

// MARK: - MovieDetailLive

struct MovieDetailLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: MovieDetailEnvType

extension MovieDetailLive: MovieDetailEnvType { }
