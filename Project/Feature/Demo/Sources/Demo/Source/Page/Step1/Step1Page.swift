import Foundation
import SwiftUI
import LinkNavigator
import Architecture

public struct Step1Page {
  let linkNavigator: LinkNavigatorURLEncodedItemProtocol
  
  public init(linkNavigator: LinkNavigatorURLEncodedItemProtocol) {
    self.linkNavigator = linkNavigator
  }
}

extension Step1Page: View {
  public var body: some View {
    VStack {
      Text("Step1Page")
      Button(action: {
        linkNavigator.backOrNext(
          linkItem: .init(
            path: "Step2",
            items: Step2Model(name: "승찬", age: 26).encoded()),
          isAnimated: true)})
      {
        Text("go step2")
      }
    }
  }
}
