import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.DirectorComponent

extension MovieDetailPage {
  struct DirectorComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.DirectorComponent { }

// MARK: - MovieDetailPage.DirectorComponent + View

extension MovieDetailPage.DirectorComponent: View {
  var body: some View {
    HStack {
      Text("Director:")

      Text(viewState.director.first(where: { $0.job == "Director" })?.name ?? "")
        .foregroundColor(.gray)
      Spacer()

      Image(systemName: "chevron.right")
        .resizable()
        .frame(width: 8, height: 10)
    }
    .padding(.horizontal, 16)
  }
}

// MARK: - MovieDetailPage.DirectorComponent.ViewState

extension MovieDetailPage.DirectorComponent {
  struct ViewState: Equatable {
    let director: [DirectorItem]

    init(rawValue: MovieDetailDomain.Response.MovieCreditResult?) {
      director = (rawValue?.crewList ?? []).map(DirectorItem.init(rawValue:))
    }
  }
}

// MARK: - MovieDetailPage.DirectorComponent.ViewState.DirectorItem

extension MovieDetailPage.DirectorComponent.ViewState {
  struct DirectorItem: Equatable {
    let name: String
    let job: String

    init(rawValue: MovieDetailDomain.Response.CrewResultItem) {
      name = rawValue.name
      job = rawValue.job
    }
  }
}
