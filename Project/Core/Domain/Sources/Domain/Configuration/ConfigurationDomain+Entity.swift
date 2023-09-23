import Foundation

// MARK: - ConfigurationDomain.Entity

extension ConfigurationDomain {
  public struct Entity {
    public let baseURL: BaseURL

    public init(baseURL: BaseURL = .init()) {
      self.baseURL = baseURL
    }
  }
}

extension ConfigurationDomain.Entity {
  public struct BaseURL: Equatable {
    public let apiURL: String
    public let apiToken: String
    public let imageURL: String

    public init(apiURL: String = "", apiToken: String = "", imageURL: String = "") {
      self.apiURL = apiURL
      self.apiToken = apiToken
      self.imageURL = imageURL
    }

    public var imageSizeURL: (ImageSizeURL) -> String {
      {
        $0.make(imageURL: imageURL)
      }
    }
  }

  public enum ImageSizeURL: Equatable {
    case small
    case medium
    case cast
    case original

    public func make(imageURL: String) -> String {
      var extenstionPath: String {
        switch self {
        case .small: return "w154"
        case .medium: return "w500"
        case .cast: return "w185"
        case .original: return "original"
        }
      }
      return [imageURL, extenstionPath].joined(separator: "/")
    }
  }
}
