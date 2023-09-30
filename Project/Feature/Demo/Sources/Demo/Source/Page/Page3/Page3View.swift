import Architecture
import Foundation
import LinkNavigator
import SwiftUI

// MARK: - Page3View

struct Page3View {
  @State private var message = ""
  let linknavigator: LinkNavigatorProtocol
  let model: DemoLink.QueryItem.Demo3?

  public init(
    linknavigator: LinkNavigatorProtocol,
    model: DemoLink.QueryItem.Demo3?)
  {
    self.linkNavigator = linkNavigator
    self.model = model
  }
}

extension Page3View { }

// MARK: View

extension Page3View: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("3")
          .font(.system(size: 80, weight: .ultraLight))

        GroupBox {
          VStack(spacing: 10) {
            HStack {
              Image(systemName: "square.stack.3d.down.right.fill")
              Text("Navigation Stack")
            }
            .font(.footnote)
            .foregroundColor(.gray)

//            Text("home -> 1 -> 2 -> 3")
          }
        }

        TextField("Type message here", text: $message)
          .textFieldStyle(.roundedBorder)
          .padding(.horizontal)

        // MARK: go to next Page with Message
        Button(action: {
          linkNavigator.next(
            linkItem: .init(
              path: DemoLink.Path.page4.rawValue,
              items: DemoLink.QueryItem.Demo4(message: message).self.encoded()), // 여기다가 메시지 넣어서 불러옴
            isAnimated: true)
        }) {
          VStack {
            Text("go to next Page with Message")
            Text("navigator.next(paths: [\"page4\"], items: [\"page4-message\": messageYouTyped], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: remove Page 1 and 2
        Button(action: {
          linkNavigator.remove(pathList: [DemoLink.Path.page1.rawValue, DemoLink.Path.page2.rawValue])
        }) {
          VStack {
            Text("remove Page 1 and 2")
              .foregroundColor(.red)
            Text("navigator.remove(paths: [\"page1\", \"page2\"])")
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

        // MARK: close (only available in modal)
        Button(action: {
          linkNavigator.close(isAnimated: true) {
            print("modal dismissed")
            self.linkNavigator.rootReloadLast(items: "", isAnimated: true) // 애니메이션이 작동 안하는 것 같음
            print("root reload last")
          }
        }) {
          VStack {
            Text("close (only available in modal)")
              .foregroundColor(.red)
            Text("navigator.close { print(\"modal dismissed\") }")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
      }
      .navigationTitle("Page 3")
    }
  }
}
