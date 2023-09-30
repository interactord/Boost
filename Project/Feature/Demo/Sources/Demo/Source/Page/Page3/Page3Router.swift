import Architecture
import Foundation
import LinkNavigator
import URLEncodedForm

struct Page3Router<RootNavigator: LinkNavigatorProtocol & LinkNavigatorFindLocationUsable>{

  static func generate() -> RouteBuilderOf<RootNavigator> {
    let matchPath = DemoLink.Path.page3.rawValue

    return .init(matchPath: matchPath) { linkNavigator, items, _ -> WrappingController<Page3View>? in
      let query = try? URLEncodedFormDecoder().decode(DemoLink.QueryItem.Demo3.self, from: items)

      return WrappingController(matchPath: matchPath) {
        Page3View(linkNavigator: linkNavigator, model: query)
      }
    }
  }
}
