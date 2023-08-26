import Architecture
import Foundation
import SwiftUI

public struct HomeView: View {

  public init() { }

  public var body: some View {
    VStack {
      Spacer()
      Asset.spongeBob.swiftUIImage
      Text("Movie View")
      Text(Architecture().text)
      Spacer()
    }
  }
}
