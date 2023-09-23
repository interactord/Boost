import Architecture
import ComposableArchitecture
import Domain
import Foundation
import LinkNavigator
import URLEncodedForm

// MARK: - MovieHomeEnvLive

struct MovieHomeEnvLive {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol

  init(
    mainQueue: AnySchedulerOf<DispatchQueue> = .main,
    useCaseGroup: MovieSideEffectGroup,
    navigator: LinkNavigatorURLEncodedItemProtocol)
  {
    self.mainQueue = mainQueue
    self.useCaseGroup = useCaseGroup
    self.navigator = navigator
  }
}

// MARK: MovieHomeEnvType

extension MovieHomeEnvLive: MovieHomeEnvType {
  var routeToMovieDetail: (MovieDomain.MovieList.Response.ResultItem) -> Void {
    { item in
      navigator.backOrNext(
        linkItem: .init(
          path: Link.Movie.Path.movieDetail.rawValue,
          items: item.encodeString()),
        isAnimated: true)
    }
  }
}
