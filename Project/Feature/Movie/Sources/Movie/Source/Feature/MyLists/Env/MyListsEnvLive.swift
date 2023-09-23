import Foundation
import LinkNavigator

struct MyListsLive {
  
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol
}

extension MyListsLive: MyListsEnvType {
}
