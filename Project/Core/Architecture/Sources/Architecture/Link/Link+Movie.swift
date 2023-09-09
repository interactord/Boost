import Foundation

extension Link {
  public enum Movie {}
}

extension Link.Movie {
  public enum Path: String, Equatable {
    case home = "movieHome"
  }
}

extension Link.Movie {
  public enum DataInjection { }
}
