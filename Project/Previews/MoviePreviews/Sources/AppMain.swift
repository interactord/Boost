import Architecture
import LinkNavigator
import SwiftUI

@main
struct AppMain: App {

  @StateObject var viewModel = AppMainViewModel()

  var body: some Scene {
    WindowGroup {
      LinkNavigationView(
        linkNavigator: viewModel.linkNavigator,
        item: .init(path: Link.Movie.Path.home.rawValue, items: ""))

        .ignoresSafeArea()
    }
  }
}
