import Foundation
import Domain
import Combine

public struct SearchUseCasePlatformMock {
  private let configurationDomain: ConfigurationDomain

  public init(configurationDomain: ConfigurationDomain) {
    self.configurationDomain = configurationDomain
  }
}

extension SearchUseCasePlatformMock {
  private var searchMovePage1: SearchDomain.Response.MovieResult {
    Files.searchMovie1Json.url
      .mapToData()
      .decoded()
  }

  private var searchKeywordPage1: SearchDomain.Response.KeywordResult {
    Files.searchKeyword1Json.url
      .mapToData()
      .decoded()
  }
}

extension SearchUseCasePlatformMock: SearchUseCase {
  public var searchMovie: (SearchDomain.Request.KeywordAndPage) -> AnyPublisher<SearchDomain.Response.MovieResult, CompositeErrorDomain> {
    { _ in
      Just(searchMovePage1)
        .delay(for: .seconds(1), scheduler: RunLoop.main)
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }

  public var searchKeyword: (SearchDomain.Request.Keyword) -> AnyPublisher<SearchDomain.Response.KeywordResult, CompositeErrorDomain> {
    { _ in
      Just(searchKeywordPage1)
        .delay(for: .seconds(1.2), scheduler: RunLoop.main)
        .setFailureType(to: CompositeErrorDomain.self)
        .eraseToAnyPublisher()
    }
  }
}

extension URL {
  fileprivate func mapToData() -> Data {
    try! Data(contentsOf: self)
  }
}

extension Data {
  fileprivate func decoded<D: Decodable>() -> D {
    try! JSONDecoder().decode(D.self, from: self)
  }
}
