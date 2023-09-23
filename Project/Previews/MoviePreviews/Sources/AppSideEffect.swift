import Architecture
import Domain
import LinkNavigator
import Movie

// MARK: - AppSideEffect

struct AppSideEffect {
  init(
    configurationDomain: ConfigurationDomain,
    movieUseCase: MovieUseCase,
    searchUseCase: SearchUseCase,
    movieDetailUseCase: MovieDetailUseCase)
  {
    self.configurationDomain = configurationDomain
    self.movieUseCase = movieUseCase
    self.searchUseCase = searchUseCase
    self.movieDetailUseCase = movieDetailUseCase
  }

  let configurationDomain: ConfigurationDomain
  let movieUseCase: MovieUseCase
  let searchUseCase: SearchUseCase
  let movieDetailUseCase: MovieDetailUseCase
}

// MARK: MovieSideEffectGroup

extension AppSideEffect: MovieSideEffectGroup { }
