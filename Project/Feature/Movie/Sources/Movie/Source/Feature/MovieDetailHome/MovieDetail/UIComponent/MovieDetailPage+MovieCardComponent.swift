import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.MovieCardComponent

extension MovieDetailPage {
  struct MovieCardComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.MovieCardComponent {
  private func formatDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    if let date = dateFormatter.date(from: dateString) {
      dateFormatter.dateFormat = "yyyy"
      return dateFormatter.string(from: date)
    } else { return "" }
  }
}

// MARK: - MovieDetailPage.MovieCardComponent + View

extension MovieDetailPage.MovieCardComponent: View {
  var body: some View {
    VStack {
      HStack(spacing: 16) {
        AsyncImage(
          url: .init(string: viewState.movieCard.imageURL),
          content: { $0.resizable() }, placeholder: { EmptyView() })
        .frame(width: 100, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 1))
        .shadow(radius: 10)

        VStack(alignment: .leading, spacing: 4) {
          Spacer()

          Group {
            HStack(spacing: .zero) {
              Text(formatDate(viewState.movieCard.releaseDate))

              Text(" • ")

              Text("\(viewState.movieCard.runningTime) minutes")

              Text(" • ")
              Text(viewState.movieCard.status)
            }
            Text(viewState.movieCard.productionCountryList.first?.name ?? "")
          }
          .font(.subheadline)
          .padding(.bottom, 8)

          HStack {
            Circle()
              .trim(from: 0, to: viewState.movieCard.voteAverage / 10)
              .stroke(
                style: StrokeStyle(lineWidth: 2, dash: [1, 1.5]))
              .rotationEffect(.degrees(-90))
              .frame(width: 40, height: 40)
              .foregroundColor(Color.lineColor(viewState.movieCard.voteAverage))
              .shadow(color: Color.lineColor(viewState.movieCard.voteAverage), radius: 5, x: 0, y: 0)
              .overlay(
                Text("\(Int(viewState.movieCard.voteAverage * 10))%")
                  .font(.caption))

            Text("\(viewState.movieCard.voteCounts) ratings")
              .font(.subheadline)
          }

          Spacer()
        }
      }
      .foregroundColor(.white)
      .padding(.vertical, 16)

      Spacer()

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 8) {
          ForEach(viewState.movieCard.generList) { genre in
            Button(action: { }) {
              Text(genre.name)
                .font(.footnote)
              Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 10, height: 10)
            }
            .foregroundColor(Color(.label))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
              RoundedRectangle(cornerRadius: 16).fill(Color.white))
          }
        }
        .padding(.leading, 24)
        .padding(.bottom, 8)

        Spacer()
      }
    }
    .background {
      GeometryReader{ geometry in
        AsyncImage(
          url: .init(string: viewState.movieCard.imageURL),
          content: { $0.resizable() }, placeholder: { EmptyView() })
        .scaledToFill()
        .overlay{
          RoundedRectangle(cornerRadius: 10)
            .background(
              .regularMaterial,
              in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay {
              RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .opacity(0.3)
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }

  }
}

// MARK: - MovieDetailPage.MovieCardComponent.ViewState

extension MovieDetailPage.MovieCardComponent {
  struct ViewState: Equatable {
    let movieCard: MovieItem

    init(rawValue: MovieDetailStore.MovieCardResultScope?) {
      movieCard = rawValue.map(MovieItem.init(rawValue:))!
    }
  }
}

extension MovieDetailPage.MovieCardComponent.ViewState {
  struct MovieItem: Equatable, Identifiable {
    let id: Int
    let imageURL: String
    let releaseDate: String
    let runningTime: Int
    let status: String
    let voteAverage: Double
    let voteCounts: Int
    let generList: [GenreItem]
    let productionCountryList: [ProductionCountryItem]

    init(rawValue: MovieDetailStore.MovieCardResultScope) {
      id = rawValue.item.id
      imageURL = {
        guard let posterPath = rawValue.item.posterPath else { return "" }
        return rawValue.imageURL + posterPath
      }()
      releaseDate = rawValue.item.releaseDate
      runningTime = rawValue.item.runtime
      status = rawValue.item.status
      voteAverage = rawValue.item.voteAverage
      voteCounts = rawValue.item.voteCount
      generList = rawValue.item.genreList.map { GenreItem(rawValue: $0) }
      productionCountryList = rawValue.item.productionCountryList.map { ProductionCountryItem(rawValue: $0) }
    }
  }

  struct GenreItem: Equatable, Identifiable {
    let id: Int
    let name: String

    init(rawValue: MovieDetailDomain.Response.GenreItem) {
      id = rawValue.id
      name = rawValue.name
    }
  }

  struct ProductionCountryItem: Equatable {
    let countryCode: String
    let name: String

    init(rawValue: MovieDetailDomain.Response.ProductionCountryItem) {
      countryCode = rawValue.countryCode
      name = rawValue.name
    }
  }

}
