import Foundation
import Combine
import Domain

public struct MovieUseCasePlatform {
  private let configurationDomain: ConfigurationDomain

  public init(configurationDomain: ConfigurationDomain) {
    self.configurationDomain = configurationDomain
  }
}

extension MovieUseCasePlatform: MovieUseCase {
  public var nowPlaying: (MovieDomain.MovieList.Request.NowPlay)
  -> AnyPublisher<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain> {
    { requestModel in
      Just(.init())
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }
}
