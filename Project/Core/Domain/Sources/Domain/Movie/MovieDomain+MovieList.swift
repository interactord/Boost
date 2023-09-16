import Foundation

extension MovieDomain {
  public enum MovieList {
    public enum Request { }
    public enum Response { }
  }
}

extension MovieDomain.MovieList.Request {
  public struct NowPlay: Equatable {
    public let language: String
    public let region: String
    public let page: Int

    public init(language: String, region: String, page: Int) {
      self.language = language
      self.region = region
      self.page = page
    }
  }
}

extension MovieDomain.MovieList.Response {
  public struct NowPlay: Equatable, Codable {
    public let totalPage: Int
    public let totalResult: Int
    public let page: Int
    public let resultList: [ResultItem]

    public init(
      totalPage: Int = .zero,
      totalResult: Int = .zero,
      page: Int = .zero,
      resultList: [ResultItem] = [])
    {
      self.totalPage = totalPage
      self.totalResult = totalResult
      self.page = page
      self.resultList = resultList
    }

    private enum CodingKeys: String, CodingKey {
      case totalPage = "total_page"
      case totalResult = "total_result"
      case page
      case resultList = "results"
    }
  }

  public struct ResultItem: Equatable, Codable {
    public let posterPath: String
    public let overview: String
    public let title: String
    public let voteAverage: Double
    public let releaseDate: String

    private enum CodingKeys: String, CodingKey {
      case posterPath = "poster_path"
      case overview
      case title
      case voteAverage = "vote_average"
      case releaseDate = "release_date"
    }

  }
}
