import Foundation

// MARK: - Reference

private final class Reference<T: Equatable>: Equatable {

  // MARK: Lifecycle

  init(_ value: T) {
    self.value = value
  }

  // MARK: Internal

  var value: T

  static func == (lhs: Reference<T>, rhs: Reference<T>) -> Bool {
    lhs.value == rhs.value
  }
}

// MARK: - Heap

@propertyWrapper
public struct Heap<T: Equatable>: Equatable {

  // MARK: Lifecycle

  public init(_ value: T) {
    reference = .init(value)
  }

  // MARK: Public

  public var wrappedValue: T {
    get { reference.value }
    set {
      if !isKnownUniquelyReferenced(&reference) {
        reference = .init(newValue)
        return
      }
      reference.value = newValue
    }
  }

  public var projectedValue: Heap<T> {
    self
  }

  // MARK: Private

  private var reference: Reference<T>

}
