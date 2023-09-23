import Foundation
import LinkNavigator
import ComposableArchitecture

struct MovieHomeLive {
  
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

extension MovieHomeLive: MovieHomeEnvType {
}
