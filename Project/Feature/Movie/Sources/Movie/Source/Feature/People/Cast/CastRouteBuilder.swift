import Architecture
import Domain
import LinkNavigator
import URLEncodedForm

struct CastRouteBuilder<RootNavigator: LinkNavigatorProtocol & LinkNavigatorFindLocationUsable>{

  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = Link.Movie.Path.cast.rawValue

    return .init(matchPath: matchPath) { navigator, item, dependency -> RouteViewController? in
      guard
        let env: MovieSideEffectGroup = dependency.resolve(),
        let query: MovieDetailDomain.Response.MovieCreditResult = item.decoded()
      else { return .none }

      return WrappingController(matchPath: matchPath) {
        CastPage(store: .init(
          initialState: CastStore.State(movieID: query.id),
          reducer: {
            CastStore(env: CastEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
