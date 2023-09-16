import Foundation

public enum CompositeErrorDomain: Error {
  case notInstanceSelf
  case invalidCasting
  case other(Error)
}

extension CompositeErrorDomain: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
    case .notInstanceSelf: return "notInstanceSelf"
    case .invalidCasting: return "invalidCasting"
    case .other(let error): return error.localizedDescription
    }
  }
}

extension CompositeErrorDomain: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.debugDescription == rhs.debugDescription
  }
}