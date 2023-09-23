import Architecture
import LinkNavigator
import Movie
import Domain

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

extension AppSideEffect: MovieSideEffectGroup {
}
