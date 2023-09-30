import Architecture
import LinkNavigator

// MARK: - MovieRouteBuilderGroup

public struct MovieRouteBuilderGroup<RootNavigator: LinkNavigatorProtocol & LinkNavigatorFindLocationUsable>{
  public init() { }
}

extension MovieRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator>] {
    [
      MovieHomeRouteBuilder.generate(),
      MyListsRouteBuilder.generate(),
      MovieDetailRouteBuilder.generate(),
      ReviewRoteBuilder.generate(),
      CastRouteBuilder.generate(),
      CrewRouteBuilder.generate(),
      SimilarMovieRouteBuilder.generate(),
      RecommendedMovieRouteBuilder.generate(),
    ]
  }
}
