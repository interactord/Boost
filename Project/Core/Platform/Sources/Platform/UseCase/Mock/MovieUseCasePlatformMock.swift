import Combine
import Domain
import Foundation

// MARK: - MovieUseCasePlatformMock

public struct MovieUseCasePlatformMock {
  private let configurationDomain: ConfigurationDomain

  public init(configurationDomain: ConfigurationDomain) {
    self.configurationDomain = configurationDomain
  }
}

extension MovieUseCasePlatformMock {
  private var nowPlaying1Json: MovieDomain.MovieList.Response.NowPlay {
    Files.nowPlaying1Json.url
      .mapToData()
      .decoded()
  }

  private var nowPlaying2Json: MovieDomain.MovieList.Response.NowPlay {
    Files.nowPlaying2Json.url
      .mapToData()
      .decoded()
  }
}

// MARK: MovieUseCase

extension MovieUseCasePlatformMock: MovieUseCase {
  public var nowPlaying: (MovieDomain.MovieList.Request.NowPlay)
    -> AnyPublisher<MovieDomain.MovieList.Response.NowPlay, CompositeErrorDomain>
  {
    { requestModel in
      print("AA ", requestModel.page)
      var response: MovieDomain.MovieList.Response.NowPlay {
        requestModel.page == 1 ? nowPlaying1Json : nowPlaying2Json
      }

      return Just(response)
        .delay(for: .seconds(1), scheduler: RunLoop.main)
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }
}

extension URL {
  fileprivate func mapToData() -> Data {
    try! Data(contentsOf: self)
  }
}

extension Data {
  fileprivate func decoded<D: Decodable>() -> D {
    try! JSONDecoder().decode(D.self, from: self)
  }
}
