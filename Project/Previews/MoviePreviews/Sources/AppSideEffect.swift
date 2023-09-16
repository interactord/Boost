import Architecture
import LinkNavigator
import Movie
import Domain

// MARK: - AppSideEffect

struct AppSideEffect {
  init(
    configurationDomain: ConfigurationDomain,
    movieUseCase: MovieUseCase,
    searchUseCase: SearchUseCase)
  {
    self.configurationDomain = configurationDomain
    self.movieUseCase = movieUseCase
    self.searchUseCase = searchUseCase
  }

  let configurationDomain: ConfigurationDomain
  let movieUseCase: MovieUseCase
  let searchUseCase: SearchUseCase
}

// MARK: MovieSideEffectGroup

extension AppSideEffect: MovieSideEffectGroup { }
