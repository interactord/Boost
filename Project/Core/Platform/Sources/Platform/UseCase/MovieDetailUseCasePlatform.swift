import Combine
import Domain
import Foundation

// MARK: - MovieDetailUseCasePlatform

public struct MovieDetailUseCasePlatform {
  private let configurationDomain: ConfigurationDomain

  public init(configurationDomain: ConfigurationDomain) {
    self.configurationDomain = configurationDomain
  }
}

extension MovieDetailUseCasePlatform {
  private var apiURL: String {
    configurationDomain.entity.baseURL.apiURL
  }

  private var apiToken: String {
    configurationDomain.entity.baseURL.apiToken
  }
}

// MARK: MovieDetailUseCase

extension MovieDetailUseCasePlatform: MovieDetailUseCase {
  public var movieCard: (MovieDetailDomain.Request.MovieCard) -> AnyPublisher<
    MovieDetailDomain.Response.MovieCardResult,
    CompositeErrorDomain
  > {
    {
      Endpoint(
        baseURL: apiURL,
        pathList: ["movie", "\($0.id)"],
        content: .queryItemPath(MovieCard(apiKey: apiToken)))
        .fetch()
    }
  }

  public var movieReview: (MovieDetailDomain.Request.Review) -> AnyPublisher<
    MovieDetailDomain.Response.MovieReviewResult,
    CompositeErrorDomain
  > {
    { _ in
      Fail(error: CompositeErrorDomain.invalidCasting)
        .eraseToAnyPublisher()
    }
  }

  public var movieCredit: (MovieDetailDomain.Request.Credit) -> AnyPublisher<
    MovieDetailDomain.Response.MovieCreditResult,
    CompositeErrorDomain
  > {
    { _ in
      Fail(error: CompositeErrorDomain.invalidCasting)
        .eraseToAnyPublisher()
    }
  }

  public var similarMovie: (MovieDetailDomain.Request.SimilarMovie) -> AnyPublisher<
    MovieDetailDomain.Response.SimilarMovieResult,
    CompositeErrorDomain
  > {
    { _ in
      Fail(error: CompositeErrorDomain.invalidCasting)
        .eraseToAnyPublisher()
    }
  }

  public var recommendedMovie: (MovieDetailDomain.Request.RecommendedMovie) -> AnyPublisher<
    MovieDetailDomain.Response.RecommenededMovieResult,
    CompositeErrorDomain
  > {
    { _ in
      Fail(error: CompositeErrorDomain.invalidCasting)
        .eraseToAnyPublisher()
    }
  }

}

// MARK: MovieDetailUseCasePlatform.MovieCard

extension MovieDetailUseCasePlatform {
  private struct MovieCard: Equatable, Codable {

    // MARK: Lifecycle

    init(apiKey: String) {
      let language = LocaleClient().language
      self.apiKey = apiKey
      self.language = language
      appendToResponse = "keywords,images"
      includeImageLanguage = [language, "en", "null"].reduce([String]()) { curr, next in
        guard !curr.contains(next) else { return curr }
        return curr + [next]
      }.joined(separator: ",")
    }

    // MARK: Internal

    let apiKey: String
    let language: String
    let appendToResponse: String
    let includeImageLanguage: String

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
      case appendToResponse = "append_to_response"
      case includeImageLanguage = "include_image_language"
    }
  }
}
