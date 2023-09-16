import Architecture
import LinkNavigator
import Movie

// MARK: - AppSideEffect

struct AppSideEffect {
  public init() { }
}

// MARK: MovieSideEffectGroup

extension AppSideEffect: MovieSideEffectGroup { }
