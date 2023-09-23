import Combine
import Domain
import Foundation

// MARK: - MovieUseCasePlatform

public struct MovieUseCasePlatform {
  private let configurationDomain: ConfigurationDomain

  public init(configurationDomain: ConfigurationDomain) {
    self.configurationDomain = configurationDomain
  }
}

// MARK: MovieUseCase

extension MovieUseCasePlatform: MovieUseCase {
  public var nowPlaying: (MovieDomain.MovieList.Request.NowPlay)
    -> AnyPublisher<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain>
  {
    { _ in
      Just(.init())
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }
}
