import Foundation

// MARK: - CompositeErrorDomain

public enum CompositeErrorDomain: Error {
  case notInstanceSelf
  case invalidCasting
  case networkError(Int)
  case other(Error)
}

// MARK: CustomDebugStringConvertible

extension CompositeErrorDomain: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
    case .notInstanceSelf: return "notInstanceSelf"
    case .invalidCasting: return "invalidCasting"
    case .networkError(let code): return "networkError : \(code)"
    case .other(let error): return error.localizedDescription
    }
  }
}

// MARK: Equatable

extension CompositeErrorDomain: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.debugDescription == rhs.debugDescription
  }
}
