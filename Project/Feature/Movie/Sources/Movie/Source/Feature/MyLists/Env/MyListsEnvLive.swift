import Foundation
import LinkNavigator

// MARK: - MyListsEnvLive

struct MyListsEnvLive {

  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorProtocol
}

// MARK: MyListsEnvType

extension MyListsEnvLive: MyListsEnvType { }
