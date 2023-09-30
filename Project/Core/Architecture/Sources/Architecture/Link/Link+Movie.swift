import Foundation

// MARK: - Link.Movie

extension Link {
  public enum Movie { }
}

// MARK: - Link.Movie.Path

extension Link.Movie {
  public enum Path: String, Equatable {
    case home = "movieHome"
    case myLists
    case movieDetail
    case review
    case cast
    case crew
    case similarMovie
    case recommendedMovie
  }
}

// MARK: - Link.Movie.DataInjection

extension Link.Movie {
  public enum DataInjection { }
}
