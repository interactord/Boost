import ComposableArchitecture
import Domain
import Foundation

// MARK: - MovieHomeEnvMock

struct MovieHomeEnvMock {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
}

// MARK: MovieHomeEnvType

extension MovieHomeEnvMock: MovieHomeEnvType {

  var routeToMovieDetail: (MovieDomain.MovieList.Response.ResultItem) -> Void {
    { _ in Void() }
  }
}
