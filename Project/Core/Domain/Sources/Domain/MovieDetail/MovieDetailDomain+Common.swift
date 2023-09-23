import Foundation

extension MovieDetailDomain {
  public enum Request { }
  public enum Response { }
}

extension MovieDetailDomain.Request {
  public struct MovieCard: Equatable, Codable {
    public let id: Int

    public init(id: Int) {
      self.id = id
    }
  }

  public struct Review: Equatable, Codable {
    public let language: String

    public init(language: String) {
      self.language = language
    }
  }

  // MARK: Credit = cast + crew
  public struct Credit: Equatable, Codable {
    public let language: String

    public init(language: String) {
      self.language = language
    }
  }

  public struct SimilarMovie: Equatable, Codable {
    public let language: String

    public init(language: String) {
      self.language = language
    }
  }

  public struct RecommendedMovie: Equatable, Codable {
    public let language: String

    public init(language: String) {
      self.language = language
    }
  }
}

extension MovieDetailDomain.Response {

  // MARK: MovieCardResult

  public struct MovieCardResult: Equatable, Codable, Identifiable {

    // MARK: Lifecycle

//    public let backdropBucket: BackdropBucket

    public init(
      id: Int = .zero,
      title: String = "",
      posterPath: String? = "",
      releaseDate: String = "",
      runtime: Int = .zero,
      status: String = "",
      voteAverage: Double = .zero,
      voteCount: Int = .zero,
      genreList: [GenreItem] = [],
      productionCountryList: [ProductionCountryItem] = [],
      overview: String = "",
      keywordBucket: KeywordBucket = KeywordBucket(),
      imageBucket: ImageBucket = ImageBucket()
//      backdropBucket: BackdropBucket = BackdropBucket()
    ) {
      self.id = id
      self.title = title
      self.posterPath = posterPath ?? ""
      self.releaseDate = releaseDate
      self.runtime = runtime
      self.status = status
      self.voteAverage = voteAverage
      self.voteCount = voteCount
      self.genreList = genreList
      self.productionCountryList = productionCountryList
      self.overview = overview
      self.keywordBucket = keywordBucket
      self.imageBucket = imageBucket
//      self.backdropBucket = backdropBucket
    }

    // MARK: Public

    public let id: Int
    public let title: String
    public let posterPath: String?
    public let releaseDate: String
    public let runtime: Int
    public let status: String
    public let voteAverage: Double
    public let voteCount: Int
    public let genreList: [GenreItem]
    public let productionCountryList: [ProductionCountryItem]
    public let overview: String
    public let keywordBucket: KeywordBucket
    public let imageBucket: ImageBucket

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case posterPath = "poster_path"
      case releaseDate = "release_date"
      case runtime
      case status
      case voteAverage = "vote_average"
      case voteCount = "vote_count"
      case genreList = "genres"
      case productionCountryList = "production_countries"
      case overview
      case keywordBucket = "keywords"
      case imageBucket = "images"
//      case backdropBucket = "images"

    }
  }

  public struct GenreItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
      case id
      case name
    }
  }

  public struct ProductionCountryItem: Equatable, Codable {
    public let countryCode: String
    public let name: String

    private enum CodingKeys: String, CodingKey {
      case countryCode = "iso_3166_1"
      case name
    }
  }

  public struct KeywordBucket: Equatable, Codable {
    public let keywordList: [KeywordItem]

    public init(keywordList: [KeywordItem] = []) {
      self.keywordList = keywordList
    }

    private enum CodingKeys: String, CodingKey {
      case keywordList = "keywords"
    }
  }

  public struct KeywordItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
      self.id = id
      self.name = name
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case name
    }
  }

  public struct ImageBucket: Equatable, Codable {
    public let posterList: [PosterItem]
    public let backdropList: [BackdropItem]

    public init(
      posterList: [PosterItem] = [],
      backdropList: [BackdropItem] = [])
    {
      self.posterList = posterList
      self.backdropList = backdropList
    }

    private enum CodingKeys: String, CodingKey {
      case posterList = "posters"
      case backdropList = "backdrops"
    }
  }

  public struct PosterItem: Equatable, Codable {
    public let poster: String?

    public init(poster: String) {
      self.poster = poster
    }

    private enum CodingKeys: String, CodingKey {
      case poster = "file_path"
    }
  }

  public struct BackdropItem: Equatable, Codable {
    public let backdropImage: String?

    public init(backdropImage: String) {
      self.backdropImage = backdropImage
    }

    private enum CodingKeys: String, CodingKey {
      case backdropImage = "file_path"
    }
  }

  // MARK: ReviewResult
  public struct MovieReviewResult: Equatable, Codable {

    // MARK: Lifecycle

    public init(
      id: Int = .zero,
      page: Int = .zero,
      totalPage: Int = .zero,
      totalResult: Int = .zero,
      resultList: [ReviewResultItem] = [])
    {
      self.id = id
      self.page = page
      self.totalPage = totalPage
      self.totalResult = totalResult
      self.resultList = resultList
    }

    // MARK: Public

    public let id: Int
    public let page: Int
    public let totalPage: Int
    public let totalResult: Int
    public let resultList: [ReviewResultItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case page
      case totalPage = "total_pages"
      case totalResult = "total_results"
      case resultList = "results"
    }
  }

  public struct ReviewResultItem: Equatable, Codable, Identifiable {
    public let id: String
    public let author: String
    public let content: String

    private enum CodingKeys: String, CodingKey {
      case id
      case author
      case content
    }
  }

  public struct MovieCreditResult: Equatable, Codable, Identifiable {
    public let id: Int
    public let castList: [CastResultItem]
    public let crewList: [CrewResultItem]

    public init(
      id: Int = .zero,
      castList: [CastResultItem] = [],
      crewList: [CrewResultItem] = [])
    {
      self.id = id
      self.castList = castList
      self.crewList = crewList
    }

    private enum CodingKeys: String, CodingKey {
      case id
      case castList = "cast"
      case crewList = "crew"
    }
  }

  public struct CastResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let name: String
    public let character: String
    public let profileImage: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case character
      case profileImage = "profile_path"
    }
  }

  public struct CrewResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let name: String
    public let department: String
    public let job: String
    public let profileImage: String?

    private enum CodingKeys: String, CodingKey {
      case id
      case name
      case department = "known_for_department"
      case job
      case profileImage = "profile_path"
    }
  }

  public struct SimilarMovieResult: Equatable, Codable {

    // MARK: Lifecycle

    public init(
      page: Int = .zero,
      totalPage: Int = .zero,
      totalResult: Int = .zero,
      resultList: [SimilarMovieResultItem] = [])
    {
      self.page = page
      self.totalPage = totalPage
      self.totalResult = totalResult
      self.resultList = resultList
    }

    // MARK: Public

    public let page: Int
    public let totalPage: Int
    public let totalResult: Int
    public let resultList: [SimilarMovieResultItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case page
      case totalPage = "total_pages"
      case totalResult = "total_results"
      case resultList = "results"
    }
  }

  public struct SimilarMovieResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let title: String
    public let voteAverage: Double

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case voteAverage = "vote_average"
    }
  }

  public struct RecommenededMovieResult: Equatable, Codable {

    // MARK: Lifecycle

    public init(
      page: Int = .zero,
      totalPage: Int = .zero,
      totalResult: Int = .zero,
      resultList: [RecommenededMovieResultItem] = [])
    {
      self.page = page
      self.totalPage = totalPage
      self.totalResult = totalResult
      self.resultList = resultList
    }

    // MARK: Public

    public let page: Int
    public let totalPage: Int
    public let totalResult: Int
    public let resultList: [RecommenededMovieResultItem]

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case page
      case totalPage = "total_pages"
      case totalResult = "total_results"
      case resultList = "results"
    }
  }

  public struct RecommenededMovieResultItem: Equatable, Codable, Identifiable {
    public let id: Int
    public let title: String
    public let voteAverage: Double

    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case voteAverage = "vote_average"
    }
  }

}

// 무비 카드
// https://api.themoviedb.org/3/movie/615656?api_key=1d9b898a212ea52e283351e521e17871&language=ko-US&append_to_response=keywords,images&include_image_language=ko,en,null

// cast + crew
// https://api.themoviedb.org/3/movie/615656/credits?api_key=1d9b898a212ea52e283351e521e17871&language=ko-US

// recommended
// https://api.themoviedb.org/3/movie/615656/recommendations?api_key=1d9b898a212ea52e283351e521e17871&language=ko-US

// similar
// https://api.themoviedb.org/3/movie/615656/similar?api_key=1d9b898a212ea52e283351e521e17871&language=ko-US

// reviews
// https://api.themoviedb.org/3/movie/615656/reviews?api_key=1d9b898a212ea52e283351e521e17871&language=ko-US&language=en-US
