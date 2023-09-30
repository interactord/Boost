import Architecture
import Foundation
import LinkNavigator
import SwiftUI

// MARK: - Page4View

struct Page4View {
  let linknavigator: LinkNavigatorProtocol
  let model: DemoLink.QueryItem.Demo4?

  public init(
    linknavigator: LinkNavigatorProtocol,
    model: DemoLink.QueryItem.Demo4?)
  {
    self.linkNavigator = linkNavigator
    self.model = model
  }
}

extension Page4View { }

// MARK: View

extension Page4View: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("4")
          .font(.system(size: 80, weight: .ultraLight))

        VStack {
          GroupBox {
            VStack(spacing: 10) {
              HStack {
                Image(systemName: "square.stack.3d.down.right.fill")
                Text("Navigation Stack")
              }
              .font(.footnote)
              .foregroundColor(.gray)

//            Text("home -> 1 -> 2 -> 3 -> 4")
            }
          }

          GroupBox {
            VStack(spacing: 10) {
              HStack {
                Image(systemName: "envelope")
                Text("Received Message")
              }
              .font(.footnote)
              .foregroundColor(.gray)

              // 앞에서 textField에서 적은 값이 나오도록 할 것
              Text(model?.message ?? "-")
            }
          }
        }

        // MARK: copy deep link
        Button(action: {
          print("Did Tapped copy deep link")
        }) {
          VStack {
            Text("copy deep link")
              .foregroundColor(.green)
            Text("URL → mvi-ex://host/home/page1/page2/page3/page4?page3-message=world&page4-message=hello")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: back to Home
        Button(action: {
          linkNavigator.backOrNext(
            linkItem: .init(
              path: DemoLink.Path.home.rawValue,
              items: ""),
            isAnimated: true)
        }) {
          VStack {
            Text("back to Home")
            Text("navigator.backOrNext(path: \"home\", items: [:], isAnimated: true)")
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

        // MARK: reset
        Button(action: {
          linkNavigator.replace(
            linkItem: .init(
              path: DemoLink.Path.home.rawValue,
              items: ""),
            isAnimated: true)
        }) {
          VStack {
            Text("reset")
              .foregroundColor(.red)
            Text("navigator.next(paths: [\"home\"], items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
      }
      .navigationTitle("Page 4")
    }
  }
}
