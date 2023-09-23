import Architecture
import LinkNavigator

struct ReviewRoteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.review.rawValue

    return .init(matchPath: matchPath) { navigator, _, dependency -> RouteViewController? in
      guard let env: MovieSideEffectGroup = dependency.resolve() else { return .none }

      return WrappingController(matchPath: matchPath) {
        ReviewPage(store: .init(
          initialState: ReviewStore.State(),
          reducer: {
            ReviewStore(env: ReviewEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
