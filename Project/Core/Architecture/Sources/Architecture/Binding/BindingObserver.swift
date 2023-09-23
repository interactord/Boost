import Combine
import Foundation

public final class BindingObserver<Value: Equatable>: ObservableObject {
  
  public init(value: Value) {
    self.value = value
  }
  
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
