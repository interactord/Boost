import Foundation
import Architecture
import LinkNavigator
import URLEncodedForm

struct Step2Router<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = "Step2"
    return .init(matchPath: matchPath) { _, items, diContainer -> WrappingController<Step2Page>? in
      let query = try? URLEncodedFormDecoder().decode(Step2Model.self, from: items)

      return WrappingController(matchPath: matchPath) {
        Step2Page(model: query ?? .init(name: "", age: .zero))
      }
    }
  }
}
