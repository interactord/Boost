import Domain
import Platform

struct MovieSideEffectGroupMock: MovieSideEffectGroup {
  init() {
    configurationDomain = .init(entity: .init())
    movieUseCase = MovieUseCasePlatformMock(configurationDomain: configurationDomain)
    searchUseCase = SearchUseCasePlatformMock(configurationDomain: configurationDomain)
    movieDetailUseCase = MovieDetailUseCasePlatformMock(configurationDomain: configurationDomain)
  }

  let configurationDomain: ConfigurationDomain
  let movieUseCase: MovieUseCase
  let searchUseCase: SearchUseCase
  let movieDetailUseCase: MovieDetailUseCase
}
