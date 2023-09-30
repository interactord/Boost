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
    {
      item in
      let requestModel = Review(apiKey: configurationDomain.entity.baseURL.apiToken)
      let endpoint = Endpoint(
        baseURL: configurationDomain.entity.baseURL.apiURL,
        pathList: ["movie", "\(item.id)", "reviews"],
        content: .queryItemPath(requestModel))
      return endpoint.fetch()

//      Endpoint(
//       baseURL: apiURL,
//       pathList: ["movie", "\($0.id)", "reviews"],
//       content: .queryItemPath(Review(apiKey: apiToken)))
//      .fetch()
    }
  }

  public var movieCredit: (MovieDetailDomain.Request.Credit) -> AnyPublisher<
    MovieDetailDomain.Response.MovieCreditResult,
    CompositeErrorDomain
  > {
    {
//      item in
//      let reqeustModel = Credit(apiKey: configurationDomain.entity.baseURL.apiToken)
//      let endpoint = Endpoint(
//        baseURL: configurationDomain.entity.baseURL.apiURL,
//        pathList: ["movie", "\(item.id)", "credits"],
//        content: .queryItemPath(reqeustModel))
//      return endpoint.fetch()

      Endpoint(
        baseURL: apiURL,
        pathList: ["movie", "\($0.id)", "credits"],
        content: .queryItemPath(Credit(apiKey: apiToken)))
        .fetch()
    }
  }

  public var similarMovie: (MovieDetailDomain.Request.SimilarMovie) -> AnyPublisher<
    MovieDetailDomain.Response.SimilarMovieResult,
    CompositeErrorDomain
  > {
    {
//      item in
//      let requestModel = SimilarMovie(apiKey: configurationDomain.entity.baseURL.apiToken)
//      let endpoint = Endpoint(
//        baseURL: configurationDomain.entity.baseURL.apiURL,
//        pathList: ["movie", "\(item.id)", "similar"],
//        content: .queryItemPath(requestModel))
//      return endpoint.fetch()

      Endpoint(
        baseURL: apiURL,
        pathList: ["movie", "\($0.id)", "similar"],
        content: .queryItemPath(SimilarMovie(apiKey: apiToken)))
        .fetch()
    }
  }

  public var recommendedMovie: (MovieDetailDomain.Request.RecommendedMovie) -> AnyPublisher<
    MovieDetailDomain.Response.RecommenededMovieResult,
    CompositeErrorDomain
  > {
    {
//      item in
//      let requestModel = Review(apiKey: configurationDomain.entity.baseURL.apiToken)
//      let endpoint = Endpoint(
//        baseURL: configurationDomain.entity.baseURL.apiURL,
//        pathList: ["movie", "\(item.id)", "recommendations"],
//        content: .queryItemPath(requestModel))
//      return endpoint.fetch()

      Endpoint(
        baseURL: configurationDomain.entity.baseURL.apiURL,
        pathList: ["movie", "\($0.id)", "recommendations"],
        content: .queryItemPath(Review(apiKey: apiToken)))
        .fetch()
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

  private struct Review: Equatable, Codable {
    let apiKey: String
    let language: String

    init(apiKey: String) {
      let language = LocaleClient().language
      self.apiKey = apiKey
      self.language = language
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
    }
  }

  private struct Credit: Equatable, Codable {
    let apiKey: String
    let language: String

    init(apiKey: String) {
      let language = LocaleClient().language
      self.apiKey = apiKey
      self.language = language
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
    }
  }

  private struct SimilarMovie: Equatable, Codable {
    let apiKey: String
    let language: String

    init(apiKey: String) {
      let language = LocaleClient().language
      self.apiKey = apiKey
      self.language = language
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
    }
  }

  private struct RecommendedMovie: Equatable, Codable {
    let apiKey: String
    let language: String

    init(apiKey: String) {
      let language = LocaleClient().language
      self.apiKey = apiKey
      self.language = language
    }

    private enum CodingKeys: String, CodingKey {
      case apiKey = "api_key"
      case language
    }
  }
}
