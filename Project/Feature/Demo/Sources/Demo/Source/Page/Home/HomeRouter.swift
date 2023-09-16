import Architecture
import Foundation
import LinkNavigator

struct HomeRouter<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = DemoLink.Path.home.rawValue

    return .init(matchPath: matchPath) { linkNavigator, _, _ -> WrappingController<HomeView>? in
      WrappingController(matchPath: matchPath) {
        HomeView(linkNavigator: linkNavigator)
      }
    }
  }
}
