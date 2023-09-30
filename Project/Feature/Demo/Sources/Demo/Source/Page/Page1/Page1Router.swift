import Architecture
import Foundation
import LinkNavigator
import URLEncodedForm

struct Page1Router<RootNavigator: LinkNavigatorProtocol & LinkNavigatorFindLocationUsable>{

  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = DemoLink.Path.page1.rawValue

    return .init(matchPath: matchPath) { linkNavigator, items, _ -> WrappingController<Page1View>? in

      let query = try? URLEncodedFormDecoder().decode(DemoLink.QueryItem.Demo.self, from: items)

      return WrappingController(matchPath: matchPath) {
        Page1View(linkNavigator: linkNavigator, model: query)
      }
    }
  }
}
