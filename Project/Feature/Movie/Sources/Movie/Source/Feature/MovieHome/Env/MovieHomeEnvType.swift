import Foundation
import Domain
import ComposableArchitecture
import Architecture

protocol MovieHomeEnvType {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var useCaseGroup: MovieSideEffectGroup { get }

  var nowPlaying: (Int)
    -> Effect<Result<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain>> { get }
}

extension MovieHomeEnvType {
  public var nowPlaying: (Int)
  -> Effect<Result<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain>> {
    { pageID in
      .publisher {
        let request = MovieDomain.MovieList.Request.NowPlay(language: "ko-kr", region: "ko", page: pageID)
        return useCaseGroup
          .movieUseCase
          .newPlaying(request)
          .mapToResult()
          .receive(on: mainQueue)
      }
    }
  }
}
