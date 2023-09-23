import Foundation
import LinkNavigator

// MARK: - MyListsLive

struct MyListsLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

// MARK: MyListsEnvType

extension MyListsLive: MyListsEnvType { }
