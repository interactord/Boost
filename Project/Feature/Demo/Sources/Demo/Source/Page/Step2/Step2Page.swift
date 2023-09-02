import Foundation
import SwiftUI

struct Step2Page {
  let model: Step2Model
}

extension Step2Page: View {
  var body: some View {
    VStack {
      Text("Step2Page")
      Text(model.name)
      Text("\(model.age)")
    }
  }
}
