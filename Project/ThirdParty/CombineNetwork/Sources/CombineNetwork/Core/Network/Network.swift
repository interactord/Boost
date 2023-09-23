import Foundation
import Combine

public struct Network {
  let endpoint: Endpoint
  let session: URLSession

  public init(
    session: URLSession = .shared,
    endpoint: Endpoint)
  {
    self.endpoint = endpoint
    self.session = session
  }
}

extension Network {

  func fetch() -> AnyPublisher<Data, NetworkError> {
    guard let request = endpoint.makeRequest() else {
      return Fail(error: NetworkError(data: .none, statusCode: .none, error: .none, debugDescription: "invalidURLRequest"))
        .eraseToAnyPublisher()
    }

    return session
      .dataTaskPublisher(for: request)
      .tryMap() { data, response -> Data in
        guard let res = response as? HTTPURLResponse else {
          throw NetworkError(data: data, statusCode: .none, error: .none, debugDescription: "invalid type casting response as? HTTPURLResponse")
        }
        guard (200...299).contains(res.statusCode) else {
          throw NetworkError(data: data, statusCode: res.statusCode, error: .none, debugDescription: "invalide response")
        }

        return data
      }
      .mapError { NetworkError.flat(error: $0) }
      .eraseToAnyPublisher()
  }
}
