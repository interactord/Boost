import Foundation

// MARK: - MovieDomain.MovieList

extension MovieDomain {
  public enum MovieList {
    public enum Request { }
    public enum Response { }
  }
}

// MARK: - MovieDomain.MovieList.Request.NowPlay

extension MovieDomain.MovieList.Request {
  public struct NowPlay: Equatable {
    public let region: String
    public let page: Int

    public init(region: String, page: Int) {
      self.region = region
      self.page = page
    }

    public init(locale: Locale, page: Int) {
      region = locale.region?.identifier ?? "US"
      self.page = page
    }
  }
}

extension MovieDomain.MovieList.Response {
  public struct NowPlay: Equatable, Codable {

    // MARK: Lifecycle

    public init(
      totalPages: Int = .zero,
      totalResult: Int = .zero,
      page: Int = .zero,
      resultList: [ResultItem] = [])
    {
      self.totalPages = totalPages
      self.totalResult = totalResult
      self.page = page
      self.resultList = resultList
    }

    // MARK: Public

    public let totalPages: Int
    public let totalResult: Int
    public let page: Int
    public let resultList: [ResultItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case totalPages = "total_pages"
      case totalResult = "total_results"
      case page
      case resultList = "results"
    }
  }

  public struct ResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let posterPath: String
    public let overview: String
    public let title: String
    public let voteAverage: Double
    public let releaseDate: String

    private enum CodingKeys: String, CodingKey {
      case id
      case posterPath = "poster_path"
      case overview
      case title
      case voteAverage = "vote_average"
      case releaseDate = "release_date"
    }
  }
}
