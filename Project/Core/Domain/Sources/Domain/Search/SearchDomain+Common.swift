import Foundation

extension SearchDomain {
  public enum Request { }
  public enum Response { }
}

extension SearchDomain.Request {
  public struct KeywordAndPage: Equatable, Codable {
    public let language: String
    public let query: String
    public let page: Int

    public init(language: String, query: String, page: Int) {
      self.language = language
      self.query = query
      self.page = page
    }
  }

  public struct Keyword: Equatable, Codable {
    public let language: String
    public let query: String

    public init(language: String, query: String) {
      self.language = language
      self.query = query
    }
  }
}

extension SearchDomain.Response {
  public struct MovieResult: Equatable, Codable {

    // MARK: Lifecycle

    public init(
      totalPages: Int = .zero,
      totalResult: Int = .zero,
      page: Int = .zero,
      resultList: [MovieResultItem] = [])
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
    public let resultList: [MovieResultItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case totalPages = "total_pages"
      case totalResult = "total_results"
      case page
      case resultList = "results"
    }
  }

  // MovieResult -> resultList -> MovieResultItem
  public struct MovieResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let posterPath: String?
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

  public struct KeywordResult: Equatable, Codable {

    // MARK: Lifecycle

    public init(
      totalPages: Int = .zero,
      totalResult: Int = .zero,
      page: Int = .zero,
      resultList: [KeywordResultItem] = [])
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
    public let resultList: [KeywordResultItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case totalPages = "total_pages"
      case totalResult = "total_results"
      case page
      case resultList = "results"
    }
  }

  public struct KeywordResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
    }
  }

  // 여기는 사람
  public struct PeopleResult: Equatable, Codable {

    // MARK: Lifecycle

    public init(
      totalPages: Int = .zero,
      totalResult: Int = .zero,
      page: Int = .zero,
      resultList: [PersonResultItem] = [])
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
    public let resultList: [PersonResultItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case totalPages = "total_pages"
      case totalResult = "total_results"
      case page
      case resultList = "results"
    }
  }

  public struct PersonResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let name: String
    public let profilePath: String?
    public let appearanceList: [Appearance]

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case profilePath = "profile_path"
      case appearanceList = "known_for"
    }
  }

  public struct Appearance: Equatable, Codable, Identifiable {
    public let id: Int
    public let title: String?
    public let originalTitle: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case originalTitle = "original_title"
    }
  }
}
