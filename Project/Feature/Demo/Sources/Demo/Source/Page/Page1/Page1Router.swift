import Foundation
import Architecture
import LinkNavigator
import URLEncodedForm

struct Page1Router<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  
  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = DemoLink.Path.page1.rawValue
    
    return .init(matchPath: matchPath) { linkNavigator, items, diContainer -> WrappingController<Page1View>? in
      
      let query = try? URLEncodedFormDecoder().decode(DemoLink.QueryItem.Demo.self, from: items)
      
      return WrappingController(matchPath: matchPath) {
        Page1View(linkNavigator: linkNavigator, model: query)
      }
    }
  }
}
