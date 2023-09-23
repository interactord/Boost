import Foundation
import Architecture
import LinkNavigator
import URLEncodedForm

  
struct Page4Router<RootNavigator: LinkNavigatorURLEncodedItemProtocol & LinkNavigatorFindLocationUsable> {
  
  static func generate() -> RouteBuilderOf<RootNavigator, LinkNavigatorURLEncodedItemProtocol.ItemValue> {
    let matchPath = DemoLink.Path.page4.rawValue
    
    return .init(matchPath: matchPath) { linkNavigator, items, diContainer -> WrappingController<Page4View>? in
      let query = try? URLEncodedFormDecoder().decode(DemoLink.QueryItem.Demo4.self, from: items)
      
      return WrappingController(matchPath: matchPath) {
        Page4View(linkNavigator: linkNavigator, model: query)
      }
    }
  }
}


// for 문 쓰지 말고 함수형으로 풀기 -> map, fillter
// reduce -> dictionary 타입에 key value
// map, forEach

// checkbox

// 스유 라이프사이클과 같음 => @StateObject에 다가 넘길
//
