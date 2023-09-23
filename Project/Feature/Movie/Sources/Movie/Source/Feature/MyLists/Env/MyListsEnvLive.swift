import Foundation
import LinkNavigator

// MARK: - MyListsEnvLive

struct MyListsEnvLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: MyListsEnvType

extension MyListsEnvLive: MyListsEnvType { }
