import Foundation

// MARK: - FetchState

public enum FetchState { }

// MARK: FetchState.Empty

extension FetchState {
  public struct Empty: Equatable {
    public var isLoading = false

    public init(isLoading: Bool) {
      self.isLoading = isLoading
    }

    public init() {
      isLoading = false
    }

    public func mutate(isLoading: Bool) -> Self {
      .init(isLoading: isLoading)
    }

    public static var `default`: Self {
      .init(isLoading: false)
    }
  }
}

// MARK: FetchState.Data

extension FetchState {
  public struct Data<V: Equatable>: Equatable {
    public var isLoading = false
    public var value: V

    public init(isLoading: Bool, value: V) {
      self.isLoading = isLoading
      self.value = value
    }

    public func mutate(isLoading: Bool) -> Self {
      .init(isLoading: isLoading, value: value)
    }

    public func mutate(value: V) -> Self {
      .init(isLoading: isLoading, value: value)
    }
  }
}
