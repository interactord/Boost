import ComposableArchitecture
import Foundation
import LinkNavigator

// MARK: - MovieDetailLive

struct MovieDetailLive {

  let mainQueue: AnySchedulerOf<DispatchQueue>
  let useCaseGroup: MovieSideEffectGroup
  let navigator: LinkNavigatorURLEncodedItemProtocol

  init(
    mainQueue: AnySchedulerOf<DispatchQueue> = .main,
    useCaseGroup: MovieSideEffectGroup,
    navigator: LinkNavigatorURLEncodedItemProtocol)
  {
    self.mainQueue = mainQueue
    self.useCaseGroup = useCaseGroup
    self.navigator = navigator
  }
}

// MARK: MovieDetailEnvType

extension MovieDetailLive: MovieDetailEnvType { }
