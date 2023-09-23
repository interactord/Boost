import Architecture
import Foundation
import LinkNavigator
import SwiftUI

// MARK: - Page1View

public struct Page1View {
  let linkNavigator: LinkNavigatorURLEncodedItemProtocol
  let model: DemoLink.QueryItem.Demo?

  public init(
    linkNavigator: LinkNavigatorURLEncodedItemProtocol,
    model: DemoLink.QueryItem.Demo?)
  {
    self.linkNavigator = linkNavigator
    self.model = model
  }
}

// MARK: View

extension Page1View: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("1")
          .font(.system(size: 80, weight: .ultraLight))

        GroupBox {
          VStack(spacing: 10) {
            HStack {
              Image(systemName: "square.stack.3d.down.right.fill")
              Text("Navigation Stack")
            }
            .font(.footnote)
            .foregroundColor(.gray)

//            Text("home -> 1")
          }
        }

        // MARK: go to next Page
        Button(action: {
          linkNavigator.next(
            linkItem: .init(
              path: DemoLink.Path.page2.rawValue,
              items: DemoLink.QueryItem.Demo2().encoded()),
            isAnimated: true)
        }) {
          VStack {
            Text("go to next Page")
            Text("navigator.next(paths: [\"page2\"], items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: back Or Next
        Button(action: {
          linkNavigator.backOrNext(
            linkItem: .init(
              path: Bool.random() ? DemoLink.Path.home.rawValue : DemoLink.Path.page2.rawValue ,
              items: ""),
            isAnimated: true)
        }) {
          VStack {
            Text("backOrNext")
            Text("navigator.backOrNext(path: Bool.random() ? \"home\" : \"page2\", items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: root Back Or Next
        Button(action: {
          linkNavigator.rootBackOrNext(
            linkItem: .init(
              path: Bool.random() ? DemoLink.Path.home.rawValue : DemoLink.Path.page2.rawValue ,
              items: ""),
            isAnimated: true)
        }) {
          VStack {
            Text("**root** backOrNext")
            Text("navigator.backOrNext(path: Bool.random() ? \"home\" : \"page2\", items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: back
        Button(action: {
          linkNavigator.back(isAnimated: true)
        }) {
          VStack {
            Text("back")
            Text("navigator.back(isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
      }
      .navigationTitle("Page 1")
    }
  }
}
