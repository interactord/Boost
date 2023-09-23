import Combine
import Domain
import Foundation

extension Endpoint {
  func fetch<D: Decodable>(session: URLSession = .shared) -> AnyPublisher<D, CompositeErrorDomain> {
    makeRequest()
      .flatMap(session.fetchData)
      .decode(type: D.self, decoder: JSONDecoder())
      .catch { Fail(error: $0.serialized()) }
      .eraseToAnyPublisher()
  }
}

extension URLSession {
  fileprivate var fetchData: (URLRequest) -> AnyPublisher<Data, CompositeErrorDomain> {
    {
      self.dataTaskPublisher(for: $0)
        .tryMap { data, response in
          print(response.url?.absoluteString ?? "")

          guard let urlResponse = response as? HTTPURLResponse
          else { throw CompositeErrorDomain.invalidCasting }

          guard (200...299).contains(urlResponse.statusCode)
          else { throw CompositeErrorDomain.networkError(urlResponse.statusCode) }

          return data
        }
        .catch { Fail(error: $0.serialized()) }
        .eraseToAnyPublisher()
    }
  }
}

extension Endpoint {
  private var makeRequest: () -> AnyPublisher<URLRequest, CompositeErrorDomain> {
    {
      Future<URLRequest, CompositeErrorDomain> { promise in
        guard let request else { return promise(.failure(.invalidCasting)) }
        return promise(.success(request))
      }
      .eraseToAnyPublisher()
    }
  }
}

extension Error {
  fileprivate func serialized() -> CompositeErrorDomain {
    guard let error = self as? CompositeErrorDomain else {
      return CompositeErrorDomain.other(self)
    }
    return error
  }
}
