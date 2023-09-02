import Architecture
import LinkNavigator
import Demo

final class AppContainer {

  private init(
    dependency: AppSideEffect,
    navigator: SingleLinkNavigator<String>)
  {
    self.dependency = dependency
    self.navigator = navigator
  }

  let dependency: AppSideEffect
  let navigator: SingleLinkNavigator<String>

}

extension AppContainer {
  class func build() -> AppContainer {
    let dependency = AppSideEffect()
    return .init(
      dependency: dependency,
      navigator: .init(
        rootNavigator: .init(initialLinkItem: .init(path: .empty, items: .empty)),
        routeBuilderItemList: DemoRouterBuildGroup.release,
        dependency: dependency))
  }
}