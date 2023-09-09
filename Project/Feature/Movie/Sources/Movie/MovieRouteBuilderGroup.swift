import Architecture
import LinkNavigator

public struct MovieRouteBuilderGroup<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  public init() { }
}

extension MovieRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue>] {
    [
      MovieHomeRouteBuilder.generate()
    ]
  }
}
