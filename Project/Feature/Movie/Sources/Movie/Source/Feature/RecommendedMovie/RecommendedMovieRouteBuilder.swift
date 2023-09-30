import Architecture
import Domain
import LinkNavigator
import URLEncodedForm

struct RecommendedMovieRouteBuilder<RootNavigator: LinkNavigatorProtocol & LinkNavigatorFindLocationUsable>{

  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.recommendedMovie.rawValue

    return .init(matchPath: matchPath) { navigator, _, dependency -> RouteViewController? in
      guard
        let env: MovieSideEffectGroup = dependency.resolve()

      else { return .none }

      return WrappingController(matchPath: matchPath) {
        RecommendedMoviePage(store: .init(
          initialState: RecommendedMovieStore.State(),
          reducer: {
            RecommendedMovieStore(env: RecommendedMovieEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
