import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - RecommendedMovieEnvType

protocol RecommendedMovieEnvType {
  var mainQueue: AnySchedulerOf<DispatchQueue> { get }
  var useCaseGroup: MovieSideEffectGroup { get }
}

extension RecommendedMovieEnvType { }
