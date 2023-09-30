import Architecture
import LinkNavigator

// MARK: - MovieRouteBuilderGroup

public struct MovieRouteBuilderGroup<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  public init() { }
}

extension MovieRouteBuilderGroup {
  public static var release: [RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue>] {
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
