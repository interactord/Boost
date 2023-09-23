import Foundation
import SwiftUI
import LinkNavigator
import Architecture

public struct Page2View {
  let linkNavigator: LinkNavigatorURLEncodedItemProtocol
  let model: DemoLink.QueryItem.Demo2?
  
  public init(
    linkNavigator: LinkNavigatorURLEncodedItemProtocol,
    model: DemoLink.QueryItem.Demo2?)
  {
    self.linkNavigator = linkNavigator
    self.model = model
  }
}

extension Page2View: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("2")
          .font(.system(size: 80, weight: .ultraLight))
        
        GroupBox {
          VStack(spacing: 10) {
            HStack {
              Image(systemName: "square.stack.3d.down.right.fill")
              Text("Navigation Stack")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            
//            Text("home -> 1 -> 2")  // path
          }
        }
        
        // MARK: go to next Page
        Button(action: {
          linkNavigator.next(
            linkItem: .init(
              path: DemoLink.Path.page3.rawValue,
              items: DemoLink.QueryItem.Demo3().encoded()),
            isAnimated: true) })
        {
          VStack {
            Text("go to next Page")
            Text("navigator.next(paths: [\"page3\"], items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
        
        // MARK: root next
        Button(action: {
          linkNavigator.rootNext(
            linkItem: .init(
              path: DemoLink.Path.page3.rawValue,
              items: DemoLink.QueryItem.Demo3().encoded()),
            isAnimated: true) })
        {
          VStack {
            Text("**root** next")
            Text("navigator.next(paths: [\"page3\"], items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
        
        // MARK: remove Page 1
        Button(action: {
          linkNavigator.remove(pathList: [DemoLink.Path.page1.rawValue]) })
        {
          VStack {
            Text("remove Page 1")
              .foregroundColor(.red)
            Text("navigator.remove(paths: [\"page1\"])")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
        
        // MARK: back
        Button(action: {
          linkNavigator.back(isAnimated: true) })
        {
          VStack {
            Text("back")
            Text("navigator.back(isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
        
      }
      .navigationTitle("Page 2")
    }
  }
}

