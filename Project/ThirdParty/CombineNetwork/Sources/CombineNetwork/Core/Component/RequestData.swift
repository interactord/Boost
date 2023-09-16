import Foundation
import URLEncodedForm

// MARK: - RequestData

public enum RequestData {
  case query(Encodable)
  case json(Encodable)
//  case binaryData(Data)
//  case form([String: Any])
}

extension RequestData {
  var rawData: Data? {
    switch self {
    case .query(let item):
      return try? URLEncodedFormEncoder().encode(item)
    case .json(let item):
      return try? JSONEncoder().encode(item)
//    case .binaryData(<#T##Data#>)
    }
  }
}

// MARK: Equatable

extension RequestData: Equatable {

  // MARK: Public

  public static func == (lhs: RequestData, rhs: RequestData) -> Bool {
    lhs.id == rhs.id
  }

  // MARK: Private

  private var id: String {
    switch self {
    case .query(let data): return "\(data)"
    case .json(let data): return "\(data)"
//    case .binaryData(let data): return "\(data)"
//    case .form(let itemList): return "(\(itemList))"
    }
  }

}
