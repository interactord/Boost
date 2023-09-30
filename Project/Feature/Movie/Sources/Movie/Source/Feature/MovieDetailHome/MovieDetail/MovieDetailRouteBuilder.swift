import Architecture
import Domain
import LinkNavigator
import URLEncodedForm

struct MovieDetailRouteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.movieDetail.rawValue

    return .init(matchPath: matchPath) { navigator, item, dependency -> RouteViewController? in
      guard
        let env: MovieSideEffectGroup = dependency.resolve(),
        let query: MovieDomain.MovieList.Response.ResultItem = item.decodedObject()
      else { return .none }

      return WrappingController(matchPath: matchPath) {
        MovieDetailPage(store: .init(
          initialState: MovieDetailStore.State(movieID: query.id),
          reducer: {
            MovieDetailStore(env: MovieDetailEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
