import Foundation
import ComposableArchitecture
import Architecture
import Domain

public struct MovieDetailStore {
  let pageID: String
  let env: MovieDetailEnvType
  init(pageID: String = UUID().uuidString, env: MovieDetailEnvType) {
    self.pageID = pageID
    self.env = env
  }
}

extension MovieDetailStore {
  public struct State: Equatable {
    
    init() {
      _fetchMovieCard = .init(.init(isLoading: false, value: .init()))
      _fetchMovieReview = .init(.init(isLoading: false, value: .init()))
      _fetchMovieCredit = .init(.init(isLoading: false, value: .init()))
      _fetchSimilarMovie = .init(.init(isLoading: false, value: .init()))
      _fetchRecommendedMovie = .init(.init(isLoading: false, value: .init()))
    }
    
    @Heap var fetchMovieCard: FetchState.Data<MovieDetailDomain.Response.MovieCardResult?>
    @Heap var fetchMovieReview: FetchState.Data<MovieDetailDomain.Response.MovieReviewResult?>
    @Heap var fetchMovieCredit: FetchState.Data<MovieDetailDomain.Response.MovieCreditResult?>
    @Heap var fetchSimilarMovie: FetchState.Data<MovieDetailDomain.Response.SimilarMovieResult?>
    @Heap var fetchRecommendedMovie: FetchState.Data<MovieDetailDomain.Response.RecommenededMovieResult?>
  }
}

extension MovieDetailStore.State {
}

extension MovieDetailStore {
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown
    
    case getMovieDetail
    
    case fetchMovieCard(Result<MovieDetailDomain.Response.MovieCardResult, CompositeErrorDomain>)
    case fetchMovieReview(Result<MovieDetailDomain.Response.MovieReviewResult, CompositeErrorDomain>)
    case fetchMovieCredit(Result<MovieDetailDomain.Response.MovieCreditResult, CompositeErrorDomain>)
    case fetchSimilarMovie(Result<MovieDetailDomain.Response.SimilarMovieResult, CompositeErrorDomain>)
    case fetchRecommendedMovie(Result<MovieDetailDomain.Response.RecommenededMovieResult, CompositeErrorDomain>)
    
    
    case throwError(CompositeErrorDomain)
  }
}

extension MovieDetailStore {
  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestMovieCard
    case requestMovieReview
    case requestMovieCredit
    case requestSimilarMovie
    case requestRecommendedMovie
  }
}

extension MovieDetailStore: Reducer {
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })
        
      case .getMovieDetail:
        state.fetchMovieCard.isLoading = false
        state.fetchMovieReview.isLoading = false
        state.fetchMovieCredit.isLoading = false
        state.fetchSimilarMovie.isLoading = false
        state.fetchRecommendedMovie.isLoading = false
        return .concatenate(
          env.movieCard()
            .map(Action.fetchMovieCard)
            .cancellable(pageID: pageID, id: CancelID.requestMovieCard, cancelInFlight: true),
          env.movieReview()
            .map(Action.fetchMovieReview)
            .cancellable(pageID: pageID, id: CancelID.requestMovieReview, cancelInFlight: true),
          env.movieCredit()
            .map(Action.fetchMovieCredit)
            .cancellable(pageID: pageID, id: CancelID.requestMovieCredit, cancelInFlight: true),
          env.similarMovie()
            .map(Action.fetchSimilarMovie)
            .cancellable(pageID: pageID, id: CancelID.requestSimilarMovie, cancelInFlight: true),
          env.recommendedMovie()
            .map(Action.fetchRecommendedMovie)
            .cancellable(pageID: pageID, id: CancelID.requestRecommendedMovie, cancelInFlight: true)
          
        )
        
      case .fetchMovieCard(let result):
        state.fetchMovieCard.isLoading = false
        switch result {
        case .success(let content):
          state.fetchMovieCard.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .fetchMovieReview(let result):
        state.fetchMovieReview.isLoading = false
        switch result {
        case .success(let content):
          state.fetchMovieReview.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }
        
      case .fetchMovieCredit(let result):
        state.fetchMovieCredit.isLoading = false
        switch result {
        case .success(let content):
          state.fetchMovieCredit.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error))}
        }
        
      case .fetchSimilarMovie(let result):
        state.fetchSimilarMovie.isLoading = false
        switch result {
        case .success(let content):
          state.fetchSimilarMovie.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error))}
        }
        
      case .fetchRecommendedMovie(let result):
        state.fetchRecommendedMovie.isLoading = false
        switch result {
        case .success(let content):
          state.fetchRecommendedMovie.value = content
          return .none
        case .failure(let error):
          return .run { await $0(.throwError(error))}
        }
        
      case .throwError(let error):
        print(error)
        return .none
        
      }
    }
  }
}
