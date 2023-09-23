import Foundation

// MARK: - HttpMethod

enum HttpMethod: Equatable {
  case get
}

extension HttpMethod {
  var rawValue: String {
    switch self {
    case .get: return "GET"
    }
  }
}
