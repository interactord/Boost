import Demo
import SwiftUI

@main
struct AppMain: App {

  var body: some Scene {
    WindowGroup {
      NavigationView {
        VStack {
          Spacer()
          Step1View()
          Spacer()
        }
      }
    }
  }
}
