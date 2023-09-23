import Foundation

struct Endpoint {
  let baseURL: String
  let pathList: [String]
  let httpMethod: HttpMethod
  let content: HttpContent

  init(baseURL: String, pathList: [String], httpMethod: HttpMethod = .get, content: HttpContent) {
    self.baseURL = baseURL
    self.pathList = pathList
    self.httpMethod = httpMethod
    self.content = content
  }
}
