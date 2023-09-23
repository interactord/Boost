import ComposableArchitecture
import Domain
import Foundation

// MARK: - MovieHomeMock

struct MovieHomeMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: MovieHomeEnvType

extension MovieHomeMock: MovieHomeEnvType {
  var routeToMovieDetail: (MovieDomain.MovieList.Response.ResultItem) -> Void {
    { _ in Void() }
  }
}
