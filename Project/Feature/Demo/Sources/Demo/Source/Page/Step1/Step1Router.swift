import Foundation
import Architecture
import LinkNavigator

struct Step1Router<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = "Step1"
    return .init(matchPath: matchPath) { linkNavigator, _, diContainer -> WrappingController<Step1Page>? in
      WrappingController(matchPath: matchPath) {
        Step1Page(linkNavigator: linkNavigator)
      }
    }
  }
}
