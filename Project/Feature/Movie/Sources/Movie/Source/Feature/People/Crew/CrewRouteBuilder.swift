import Architecture
import LinkNavigator

struct CrewRouteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.crew.rawValue

    return .init(matchPath: matchPath) { navigator, _, dependency -> RouteViewController? in
      guard let env: MovieSideEffectGroup = dependency.resolve() else { return .none }

      return WrappingController(matchPath: matchPath) {
        CrewPage(store: .init(
          initialState: CrewStore.State(),
          reducer: {
            CrewStore(env: CrewEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
