import Foundation
import URLEncodedForm

extension Endpoint {
  var request: URLRequest? {
    baseURL
      .component?
      .apply(pathList: pathList)
      .apply(content: content)
      .request
  }
}

extension String {
  var component: URLComponents? {
    .init(string: self)
  }
}

extension URLComponents {
  fileprivate var request: URLRequest? {
    guard let url else { return .none }
    return .init(url: url)
  }

  fileprivate func apply(pathList: [String]) -> Self {
    var new = self
    new.path = ([path] + pathList).joined(separator: "/")
    return new
  }

  fileprivate func apply(content: Endpoint.HttpContent) -> Self {
    guard case .queryItemPath(let item) = content
    else { return self }

    var new = self
    let newQuery = item.encodeString()
    new.query = newQuery

    return new
  }
}
