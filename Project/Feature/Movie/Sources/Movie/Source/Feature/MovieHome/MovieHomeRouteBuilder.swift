import Architecture
import LinkNavigator

struct MovieHomeRouteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.home.rawValue

    return .init(matchPath: matchPath) { navigator, item, dependency in
      WrappingController(matchPath: matchPath) {
        MovieHomePage()
      }
    }
  }

}
