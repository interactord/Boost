import Combine
import Foundation

public protocol MovieUseCase {
  var nowPlaying: (MovieDomain.MovieList.Request.NowPlay)
    -> AnyPublisher<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain> { get }

}
