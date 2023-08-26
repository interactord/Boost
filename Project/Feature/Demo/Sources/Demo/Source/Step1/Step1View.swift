import Architecture
import Foundation
import SwiftUI

public struct Step1View: View {

  public init() { }

  public var body: some View {
    VStack {
      Spacer()
      Asset.spongeBob.swiftUIImage
      Text("Step1 View")
      Text(Architecture().text)
      Spacer()
    }
  }
}
