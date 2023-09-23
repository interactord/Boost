import Foundation
import Combine

public protocol MovieUseCase {
  var nowPlaying: (MovieDomain.MovieList.Request.NowPlay)
    -> AnyPublisher<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain> { get }
  
}

