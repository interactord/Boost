import Foundation
import LinkNavigator

final class AppMainViewModel: ObservableObject {

  // MARK: Lifecycle

  init() { }

  // MARK: Internal

  let appContainer = AppContainer.build()

  var linkNavigator: SingleLinkNavigator<String> {
    appContainer.navigator
  }
}
