import Foundation
import URLEncodedForm

public struct Endpoint: Equatable {

  let baseURL: String
  let path: String
  let query: [String: String]
  let httpMethod: HTTPMethod
  let header: [String: String]
  let requestData: RequestData



}

extension Endpoint {
  func makeRequest() -> URLRequest? {
    guard let url = makeURL() else { return .none }

    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.rawValue

    header.forEach {
      request.setValue($0.value, forHTTPHeaderField: $0.key)
    }

    request.httpBody = requestData.rawData
    return request
  }
}

extension Endpoint {
  private func makeURL() -> URL? {
    guard
      let url = URL(string: [baseURL, path].joined(separator: "/")),
      var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false)
    else { return .none }

    urlComponent.queryItems = query.map {
      .init(name: $0.key, value: $0.value)
    }
    return urlComponent.url
  }
}
