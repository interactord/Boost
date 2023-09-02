import Foundation
import SwiftUI

struct Step2Page {
  let model: DemoLink.QueryItem.Demo2?
}

extension Step2Page: View {
  var body: some View {
    VStack {
      Text("Step2Page")
      Text(model?.name ?? "")
      Text("\(model?.age ?? .zero)")
    }
  }
}
