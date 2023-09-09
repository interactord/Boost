import Foundation
import URLEncodedForm

extension Encodable {
  public func encoded() -> String {
    guard let data = try? URLEncodedFormEncoder().encode(self) else { return "" }
    return .init(data: data, encoding: .utf8) ?? ""
  }
}

extension URLEncodedForm {
  public static func decoded<T: Decodable>(data: Data) -> T? {
    try? URLEncodedFormDecoder().decode(T.self, from: data)
  }
}


