import Foundation
import Architecture
import LinkNavigator
import URLEncodedForm

struct Page2Router<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  
  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = DemoLink.Path.page2.rawValue
    
    return .init(matchPath: matchPath) { linkNavigator, items, diContainer -> WrappingController<Page2View>? in
      let query = try? URLEncodedFormDecoder().decode(DemoLink.QueryItem.Demo2.self, from: items)
      
      return WrappingController(matchPath: matchPath) {
        Page2View(linkNavigator: linkNavigator, model: query)
      }
    }
  }
}

