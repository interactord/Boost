import Architecture
import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: - RecommendedMoviePage

struct RecommendedMoviePage {
  private let store: StoreOf<RecommendedMovieStore>
  @ObservedObject private var viewStore: ViewStoreOf<RecommendedMovieStore>

  init(store: StoreOf<RecommendedMovieStore>) {
    self.store = store
    viewStore = ViewStore(store, observe: { $0 })
  }
}

extension RecommendedMoviePage { }

// MARK: View

extension RecommendedMoviePage: View {
  var body: some View {
    Text("Recommended movie page")
  }
}
