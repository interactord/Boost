import Foundation


extension Link {
  public enum Movie {}
}

extension Link.Movie {
  public enum Path: String, Equatable {
    case home = "movieHome"
    case myLists = "myLists"
    case movieDetail = "movieDetail"
    case review = "review"
    case cast = "cast"
    case crew = "crew"
  }
}

extension Link.Movie {
  public enum DataInjection { }
}
