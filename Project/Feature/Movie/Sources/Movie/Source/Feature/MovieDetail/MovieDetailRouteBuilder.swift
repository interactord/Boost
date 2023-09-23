import Architecture
import LinkNavigator

struct MovieDetailRouteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.movieDetail.rawValue

    return .init(matchPath: matchPath) { navigator, _, dependency -> RouteViewController? in
      guard let env: MovieSideEffectGroup = dependency.resolve() else { return .none }

      return WrappingController(matchPath: matchPath) {
        MovieDetailPage(store: .init(
          initialState: MovieDetailStore.State(),
          reducer: {
            MovieDetailStore(env: MovieDetailEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
