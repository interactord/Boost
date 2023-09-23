import Architecture
import LinkNavigator

struct MyListsRouteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.myLists.rawValue

    return .init(matchPath: matchPath) { navigator, _, dependency -> RouteViewController? in
      guard let env: MovieSideEffectGroup = dependency.resolve() else { return .none }

      return WrappingController(matchPath: matchPath) {
        MyListsPage(store: .init(
          initialState: MyListsStore.State(),
          reducer: {
            MyListsStore(env: MyListsEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
