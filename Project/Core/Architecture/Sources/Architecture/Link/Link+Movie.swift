import Foundation

// MARK: - Link.Movie

extension Link {
  public enum Movie { }
}

// MARK: - Link.Movie.Path

extension Link.Movie {
  public enum Path: String, Equatable {
    case home = "movieHome"
    case movieDetail
    case myLists = "movieMyLists"
  }
}

// MARK: - Link.Movie.DataInjection

extension Link.Movie {
  public enum DataInjection { }
}
