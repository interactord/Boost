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
    { item in
      let requestModel = NowPlay(
        apiKey: configurationDomain.entity.baseURL.apiToken,
        item: item)
      let endpoint = Endpoint(
        baseURL: configurationDomain.entity.baseURL.apiURL,
        pathList: ["movie", "now_playing"],
        content: .queryItemPath(requestModel))

      return endpoint.fetch()
    }
  }
}

// MARK: MovieUseCasePlatform.NowPlay

extension MovieUseCasePlatform {
  private struct NowPlay: Equatable, Codable {
    let apiKey: String
    let language: String
    let region: String
    let page: Int

    init(apiKey: String, item: MovieDomain.MovieList.Request.NowPlay) {
      self.apiKey = apiKey
      language = LocaleClient().language
      region = item.region
      page = item.page
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case region
      case page
    }
  }
}
