import Foundation

public struct NetworkError: Error {
  let data: Data?
  let statusCode: Int?
  let error: Error?
  let debugDescription: String?

  init(
    data: Data?,
    statusCode: Int?,
    error: Error?,
    debugDescription: String?)
  {
    self.data = data
    self.statusCode = statusCode
    self.error = error
    self.debugDescription = debugDescription
  }

}

extension NetworkError {
  static func other(error: Error) -> Self {
    return .init(data: .none, statusCode: .none, error: error, debugDescription: .none)
  }

  static func flat(error: Error) -> NetworkError {
    if let err = error as? Self { return err }
    return .other(error: error)
  }
}
