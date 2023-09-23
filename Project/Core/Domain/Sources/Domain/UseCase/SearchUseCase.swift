import Foundation
import Combine

public protocol SearchUseCase {
  var searchMovie: (SearchDomain.Request.KeywordAndPage)
  -> AnyPublisher<SearchDomain.Response.MovieResult, CompositeErrorDomain> { get }
  var searchKeyword: (SearchDomain.Request.Keyword)
  -> AnyPublisher<SearchDomain.Response.KeywordResult, CompositeErrorDomain> { get }
  var searchPeople: (SearchDomain.Request.KeywordAndPage)
  -> AnyPublisher<SearchDomain.Response.PeopleResult, CompositeErrorDomain> { get }
}
