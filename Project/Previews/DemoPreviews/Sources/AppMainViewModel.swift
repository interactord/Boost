import Foundation
import LinkNavigator

final class AppMainViewModel: ObservableObject {
  
  let appContainer = AppContainer.build()
  var linkNavigator: SingleLinkNavigator<String> {
    appContainer.navigator
  }
  
  init() {}
}
