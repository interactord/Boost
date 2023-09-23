import Combine
import Domain
import Foundation

// MARK: - MovieDetailUseCasePlatformMock

public struct MovieDetailUseCasePlatformMock {
  private let configurationDomain: ConfigurationDomain

  public init(configurationDomain: ConfigurationDomain) {
    self.configurationDomain = configurationDomain
  }
}

extension MovieDetailUseCasePlatformMock {
  private var movieDetailCardPage1: MovieDetailDomain.Response.MovieCardResult {
    Files.movieDetailCard1Json.url
      .mapToData()
      .decoded()
  }

  private var movieDetailReviewPage1: MovieDetailDomain.Response.MovieReviewResult {
    Files.movieDetailReview1Json.url
      .mapToData()
      .decoded()
  }

  private var movieDetailCreditPage1: MovieDetailDomain.Response.MovieCreditResult {
    Files.movieDetailCredit1Json.url
      .mapToData()
      .decoded()
  }

  private var movieSimilarPage1: MovieDetailDomain.Response.SimilarMovieResult {
    Files.movieDetailSimilar1Json.url
      .mapToData()
      .decoded()
  }

  private var movieRecommendedPage1: MovieDetailDomain.Response.RecommenededMovieResult {
    Files.movieDetailRecommended1Json.url
      .mapToData()
      .decoded()
  }

}

// MARK: MovieDetailUseCase

extension MovieDetailUseCasePlatformMock: MovieDetailUseCase {
  public var movieCard: (MovieDetailDomain.Request.MovieCard) -> AnyPublisher<
    MovieDetailDomain.Response.MovieCardResult,
    CompositeErrorDomain
  > {
    { _ in
      Just(movieDetailCardPage1)
        .delay(for: .seconds(0.5), scheduler: RunLoop.main)
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }

  public var movieReview: (MovieDetailDomain.Request.Review) -> AnyPublisher<
    MovieDetailDomain.Response.MovieReviewResult,
    CompositeErrorDomain
  > {
    { _ in
      Just(movieDetailReviewPage1)
        .delay(for: .seconds(0.1), scheduler: RunLoop.main)
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }

  public var movieCredit: (MovieDetailDomain.Request.Credit) -> AnyPublisher<
    MovieDetailDomain.Response.MovieCreditResult,
    CompositeErrorDomain
  > {
    { _ in
      Just(movieDetailCreditPage1)
        .delay(for: .seconds(0.2), scheduler: RunLoop.main)
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }

  public var similarMovie: (MovieDetailDomain.Request.SimilarMovie) -> AnyPublisher<
    MovieDetailDomain.Response.SimilarMovieResult,
    CompositeErrorDomain
  > {
    { _ in
      Just(movieSimilarPage1)
        .delay(for: .seconds(0.2), scheduler: RunLoop.main)
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }

  public var recommendedMovie: (MovieDetailDomain.Request.RecommendedMovie) -> AnyPublisher<
    MovieDetailDomain.Response.RecommenededMovieResult,
    CompositeErrorDomain
  > {
    { _ in
      Just(movieRecommendedPage1)
        .delay(for: .seconds(0.2), scheduler: RunLoop.main)
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
