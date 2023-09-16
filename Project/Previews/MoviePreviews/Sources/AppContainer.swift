import Architecture
import LinkNavigator
import Movie

// MARK: - AppContainer

final class AppContainer {

  // MARK: Lifecycle

  private init(
    dependency: AppSideEffect,
    navigator: SingleLinkNavigator<String>)
  {
    self.dependency = dependency
    self.navigator = navigator
  }

  // MARK: Internal

  let dependency: AppSideEffect
  let navigator: SingleLinkNavigator<String>
}

extension AppContainer {
  class func build() -> AppContainer {
    let dependency = AppSideEffect()
    return .init(
      dependency: dependency,
      navigator: .init(
        routeBuilderItemList: MovieRouteBuilderGroup.release,
        dependency: dependency))
  }
}
