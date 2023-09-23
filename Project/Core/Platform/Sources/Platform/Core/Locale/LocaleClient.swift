import Foundation

// MARK: - LocaleClient

struct LocaleClient {
  let origin: Locale

  init(origin: Locale = .current) {
    self.origin = origin
  }
}

extension LocaleClient {
  var language: String {
    Locale.preferredLanguages.first?.split(separator: "-").map(String.init).first ?? "en"
  }
}
