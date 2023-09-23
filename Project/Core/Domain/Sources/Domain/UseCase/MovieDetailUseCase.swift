import Combine
import Foundation

public protocol MovieDetailUseCase {
  var movieCard: (MovieDetailDomain.Request.MovieCard)
    -> AnyPublisher<MovieDetailDomain.Response.MovieCardResult, CompositeErrorDomain> { get }
  var movieReview: (MovieDetailDomain.Request.Review)
    -> AnyPublisher<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain> { get }
  var movieCredit: (MovieDetailDomain.Request.Credit)
    -> AnyPublisher<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain> { get }
  var similarMovie: (MovieDetailDomain.Request.SimilarMovie)
    -> AnyPublisher<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain> { get }
  var recommendedMovie: (MovieDetailDomain.Request.RecommendedMovie)
    -> AnyPublisher<MovieDetailDomain.Response.RecommenededMovieResult, CompositeErrorDomain> { get }
}
