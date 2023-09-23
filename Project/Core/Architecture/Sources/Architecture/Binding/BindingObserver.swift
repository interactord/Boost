import Combine
import Foundation

// MARK: - BindingObserver

public final class BindingObserver<Value: Equatable>: ObservableObject {

  // MARK: Lifecycle

  public init(value: Value) {
    self.value = value
  }

  // MARK: Public

  @Published public var value: Value

  public func update(value: Value) {
    self.value = value
  }
}

extension BindingObserver where Value == String {
  public convenience init() {
    self.init(value: "")
  }
}
