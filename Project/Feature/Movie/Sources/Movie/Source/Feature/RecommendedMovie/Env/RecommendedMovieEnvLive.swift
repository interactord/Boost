import Architecture
import ComposableArchitecture
import Domain
import Foundation
import LinkNavigator
import URLEncodedForm

// MARK: - RecommendedMovieEnvLive

struct RecommendedMovieEnvLive {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorProtocol

  init(
    mainQueue: AnySchedulerOf<DispatchQueue> = .main,
    useCaseGroup: MovieSideEffectGroup,
    navigator: LinkNavigatorProtocol)
  {
    self.mainQueue = mainQueue
    self.useCaseGroup = useCaseGroup
    self.navigator = navigator
  }
}

// MARK: RecommendedMovieEnvType

extension RecommendedMovieEnvLive: RecommendedMovieEnvType { }
