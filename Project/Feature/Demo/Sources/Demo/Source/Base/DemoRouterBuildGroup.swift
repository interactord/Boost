import Architecture
import LinkNavigator

public struct DemoRouterBuildGroup<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  public init() { }
}

extension DemoRouterBuildGroup {
  public static var realease: [RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue>] {
    [
      HomeRouter.generate(),
      Page1Router.generate(),
      Page2Router.generate(),
      Page3Router.generate(),
      Page4Router.generate(),
    ]
  }
}
