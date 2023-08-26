import Authencation
import SwiftUI

@main
struct AppMain: App {

  let auth = Authencation()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        VStack {
          Spacer()
          Text("Authencation Preview")
          Spacer()
        }
      }
    }
  }
}
