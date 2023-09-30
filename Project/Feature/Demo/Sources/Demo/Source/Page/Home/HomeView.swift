import Architecture
import Foundation
import LinkNavigator
import SwiftUI

// MARK: - HomeView

public struct HomeView {
  let linknavigator: LinkNavigatorProtocol

  public init(linknavigator: LinkNavigatorProtocol) {
    self.linkNavigator = linkNavigator
  }
}

// MARK: View

extension HomeView: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        GroupBox {
          VStack(spacing: 10) {
            HStack {
              Image(systemName: "square.stack.3d.down.right.fill")
              Text("Navigation Stack")
            }
            .font(.footnote)
            .foregroundColor(.gray)
          }
        }

        // MARK:  go to next Page
        Button(action: {
          linkNavigator.next(
            linkItem: .init(
              path: DemoLink.Path.page1.rawValue,
              items: DemoLink.QueryItem.Demo().encoded()),
            isAnimated: true)
        }) {
          VStack {
            Text("go to next Page")
            Text("navigator.next(paths: [\"page1\"], items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: go to last Page
        Button(action: {
          linkNavigator.next(
            linkItem: .init(
              pathList: [DemoLink.Path.page1.rawValue, DemoLink.Path.page2.rawValue, DemoLink.Path.page3.rawValue],
              items: ""),
            isAnimated: true)
        }) {
          VStack {
            Text("go to last Page")
            Text("navigator.next(paths: [\"page1\",\"page2\",\"page3\"], items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: show alert
        Button(action: {
          linkNavigator.alert(
            target: .default,
            model: .init(
              title: "Title",
              message: "message",
              buttons: [.init(title: "Ok", style: .default, action: { print("Ok tapped") })],
              flagType: .default))
        }) {
          VStack {
            Text("show alert")
              .foregroundColor(Color(.systemYellow))
            Text("navigator.alert(target: .default, model: alertModel)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: open Page 2 as Sheet
        Button(action: {
          linkNavigator.sheet(
            linkItem: .init(
              pathList: [DemoLink.Path.page1.rawValue, DemoLink.Path.page2.rawValue],
              items: ""),
            isAnimated: true)
        }) {
          VStack {
            Text("open Page 2 as Sheet")
              .foregroundColor(.purple)
            Text("navigator.sheet(paths: [\"page1\", \"page2\"], items: [:], isAnimated: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }

        // MARK: open Page 2 Full Screen Sheet
        Button(action: {
          linkNavigator.fullSheet(
            linkItem: .init(
              pathList: [DemoLink.Path.page1.rawValue, DemoLink.Path.page2.rawValue],
              items: ""),
            isAnimated: true,
            prefersLargeTitles: true)
        }) {
          VStack {
            Text("open Page 2 Full Screen Sheet")
              .foregroundColor(.purple)
            Text("navigator.next(paths: [\"page2\"], items: [:], isAnimated: true, prefersLargeTitles: true)")
              .font(.caption)
              .foregroundColor(.gray)
          }
        }
      }

      .navigationTitle("Home")
    }
  }
}
