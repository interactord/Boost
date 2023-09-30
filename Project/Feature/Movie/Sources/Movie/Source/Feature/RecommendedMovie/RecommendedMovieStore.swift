import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - RecommendedMovieStore

public struct RecommendedMovieStore {
  let pageID: String
  let env: RecommendedMovieEnvType

  init(pageID: String = UUID().uuidString, env: RecommendedMovieEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

// MARK: RecommendedMovieStore.State

extension RecommendedMovieStore {
  public struct State: Equatable {
//    let movieID: Int
//
//    init(movieID: Int) {
//      self.movieId = movieID
//    }
//
  }
}

extension RecommendedMovieStore.State { }

// MARK: - RecommendedMovieStore.Action

extension RecommendedMovieStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

  }
}

// MARK: - RecommendedMovieStore + Reducer

extension RecommendedMovieStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { _, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .none
      }
    }
  }
}
