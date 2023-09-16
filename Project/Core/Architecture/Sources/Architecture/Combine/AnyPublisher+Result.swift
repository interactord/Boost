import Combine

extension Publisher {
  public func mapToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
    map(Result.success)
      .catch { Just(.failure($0)) }
      .eraseToAnyPublisher()
  }
}
