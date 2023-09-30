import Architecture
import LinkNavigator

// MARK: - DemoRouterBuildGroup

public struct DemoRouterBuildGroup<RootNavigator: LinkNavigatorProtocol & LinkNavigatorFindLocationUsable>{
  public init() { }
}

extension DemoRouterBuildGroup {
  public static var realease: [RouteBuilderOf<RootNavigator>] {
    [
      HomeRouter.generate(),
      Page1Router.generate(),
      Page2Router.generate(),
      Page3Router.generate(),
      Page4Router.generate(),
    ]
  }
}
