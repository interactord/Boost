import Movie
import SwiftUI

@main
struct AppMain: App {

  var body: some Scene {
    WindowGroup {
      NavigationView {
        VStack {
          Spacer()
          HomeView()
          Spacer()
        }
      }
    }
  }
}
