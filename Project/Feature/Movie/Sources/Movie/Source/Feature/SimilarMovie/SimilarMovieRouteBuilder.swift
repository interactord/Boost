import Architecture
import Domain
import LinkNavigator
import URLEncodedForm

struct SimilarMovieRouteBuilder<RootNavigator: LinkNavigatorProtocol & LinkNavigatorFindLocationUsable>{

  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.similarMovie.rawValue

    return .init(matchPath: matchPath) { navigator, item, dependency -> RouteViewController? in
      guard
        let env: MovieSideEffectGroup = dependency.resolve(),
        let query: MovieDetailDomain.Response.SimilarMovieResult = item.decoded()
      else { return .none }

      return WrappingController(matchPath: matchPath) {
        SimilarMoviePage(store: .init(
          initialState: SimilarMovieStore.State(movieID: 565770),
          reducer: {
            SimilarMovieStore(env: SimilarMovieEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
