// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length line_length implicit_return

// MARK: - Files

// swiftlint:disable explicit_type_interface identifier_name
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Files {
  /// movieDetail_card_1.json
  internal static let movieDetailCard1Json = File(name: "movieDetail_card_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// movieDetail_credit_1.json
  internal static let movieDetailCredit1Json = File(name: "movieDetail_credit_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// movieDetail_recommended_1.json
  internal static let movieDetailRecommended1Json = File(name: "movieDetail_recommended_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// movieDetail_review_1.json
  internal static let movieDetailReview1Json = File(name: "movieDetail_review_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// movieDetail_similar_1.json
  internal static let movieDetailSimilar1Json = File(name: "movieDetail_similar_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// now_playing_1.json
  internal static let nowPlaying1Json = File(name: "now_playing_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// now_playing_2.json
  internal static let nowPlaying2Json = File(name: "now_playing_2", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_keyword_1.json
  internal static let searchKeyword1Json = File(name: "search_keyword_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_movie_1.json
  internal static let searchMovie1Json = File(name: "search_movie_1", ext: "json", relativePath: "", mimeType: "application/json")
  /// search_person_1.json
  internal static let searchPerson1Json = File(name: "search_person_1", ext: "json", relativePath: "", mimeType: "application/json")
}
// swiftlint:enable explicit_type_interface identifier_name
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

internal struct File {
  internal let name: String
  internal let ext: String?
  internal let relativePath: String
  internal let mimeType: String

  internal var url: URL {
    return url(locale: nil)
  }

  internal func url(locale: Locale?) -> URL {
    let bundle = BundleToken.bundle
    let url = bundle.url(
      forResource: name,
      withExtension: ext,
      subdirectory: relativePath,
      localization: locale?.identifier
    )
    guard let result = url else {
      let file = name + (ext.flatMap { ".\($0)" } ?? "")
      fatalError("Could not locate file named \(file)")
    }
    return result
  }

  internal var path: String {
    return path(locale: nil)
  }

  internal func path(locale: Locale?) -> String {
    return url(locale: locale).path
  }
}

// swiftlint:disable convenience_type explicit_type_interface
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type explicit_type_interface
