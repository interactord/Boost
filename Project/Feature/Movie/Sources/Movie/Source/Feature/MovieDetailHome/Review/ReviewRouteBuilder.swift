import Architecture
import Domain
import LinkNavigator
import URLEncodedForm

struct ReviewRoteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.review.rawValue

    return .init(matchPath: matchPath) { navigator, item, dependency -> RouteViewController? in
      guard
        let env: MovieSideEffectGroup = dependency.resolve(),
        let query: MovieDetailDomain.Response.MovieReviewResult = item.decodedObject()
      else { return .none }

      return WrappingController(matchPath: matchPath) {
        ReviewPage(store: .init(
          initialState: ReviewStore.State(movieID: query.id),
          reducer: {
            ReviewStore(env: ReviewEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
