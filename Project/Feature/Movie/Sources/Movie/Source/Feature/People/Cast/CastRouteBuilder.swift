import Architecture
import LinkNavigator

struct CastRouteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.cast.rawValue

    return .init(matchPath: matchPath) { navigator, _, dependency -> RouteViewController? in
      guard let env: MovieSideEffectGroup = dependency.resolve() else { return .none }

      return WrappingController(matchPath: matchPath) {
        CastPage(store: .init(
          initialState: CastStore.State(),
          reducer: {
            CastStore(env: CastEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
