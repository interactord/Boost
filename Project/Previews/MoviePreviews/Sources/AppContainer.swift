import Architecture
import LinkNavigator
import Movie
import Domain
import Platform

final class AppContainer {
   init(
    dependency: AppSideEffect,
    navigator: SingleLinkNavigator<String>
  )
  {
    self.dependency = dependency
    self.navigator = navigator
  }
  
  let dependency: AppSideEffect
  let navigator: SingleLinkNavigator<String>
}

extension AppContainer {
  class func build() -> AppContainer {
    let configuration = Self.configurationLive
    let dependency = AppSideEffect(
      configurationDomain: configuration,
      movieUseCase: MovieUseCasePlatformMock(
        configurationDomain: configuration),
      searchUseCase: SearchUseCasePlatformMock(
        configurationDomain: configuration),
    movieDetailUseCase: MovieDetailUseCasePlatformMock(
      configurationDomain: configuration)
    )
    return .init(
      dependency: dependency,
      navigator: .init(
        routeBuilderItemList: MovieRouteBuilderGroup.release,
        dependency: dependency))
  }
}

extension AppContainer {
  fileprivate class var configurationLive: ConfigurationDomain {
     .init(
      entity: .init(
        baseURL: .init(
          apiURL: "https://api.themoviedb.org/3",
          apiToken: "1d9b898a212ea52e283351e521e17871",
          imageURL: "https://image.tmdb.org/t/p/")))
  }
}
