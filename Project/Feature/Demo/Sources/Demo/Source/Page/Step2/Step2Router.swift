import Foundation
import Architecture
import LinkNavigator
import URLEncodedForm

struct Step2Router<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = DemoLink.Path.step2.rawValue
    return .init(matchPath: matchPath) { _, items, diContainer -> WrappingController<Step2Page>? in
      let query = try? URLEncodedFormDecoder().decode(DemoLink.QueryItem.Demo2.self, from: items)

      return WrappingController(matchPath: matchPath) {
        Step2Page(model: query)
      }
    }
  }
}
