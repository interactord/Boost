import Architecture
import Domain
import LinkNavigator

struct CrewRouteBuilder<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {

  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = Link.Movie.Path.crew.rawValue

    return .init(matchPath: matchPath) { navigator, item, dependency -> RouteViewController? in
      guard
        let env: MovieSideEffectGroup = dependency.resolve(),
        let query: MovieDetailDomain.Response.MovieCreditResult = item.decodedObject()
      else { return .none }

      return WrappingController(matchPath: matchPath) {
        CrewPage(store: .init(
          initialState: CrewStore.State(movieID: query.id),
          reducer: {
            CrewStore(env: CrewEnvLive(
              useCaseGroup: env,
              navigator: navigator))
          }))
      }
    }
  }
}
