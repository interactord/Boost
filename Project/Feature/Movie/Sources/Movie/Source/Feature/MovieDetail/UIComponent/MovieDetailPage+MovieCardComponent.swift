import Foundation
import SwiftUI

// MARK: - MovieDetailPage.MovieCardComponent

extension MovieDetailPage {
  struct MovieCardComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.MovieCardComponent { }

// MARK: - MovieDetailPage.MovieCardComponent + View

extension MovieDetailPage.MovieCardComponent: View {
  var body: some View {
    LazyVStack {
      HStack(spacing: 16) {
        Asset.spongeBob.swiftUIImage
          .resizable()
          .frame(width: 100, height: 140)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.black, lineWidth: 1))
          .shadow(radius: 10)

        VStack(alignment: .leading) {
          Spacer()

          HStack(spacing: .zero) {
            Text(viewState.movieCard.releaseDate)

            Text(" • ")

            Text("\(viewState.movieCard.runningTime) minutes")

            Text(" • ")
            Text("Released \(viewState.movieCard.releasedCountry)")
          }
          .font(.subheadline)
          //          .lineLimit(2)
          //          .multilineTextAlignment(.leading)

          HStack {
            Circle()
              .trim(from: 0, to: 0.75)
              .stroke(
                style: StrokeStyle(lineWidth: 2, dash: [1, 1.5]))
              .rotationEffect(.degrees(-90))
              .frame(width: 40, height: 40)
              .foregroundColor(Color.lineColor(viewState.movieCard.voteAverage))
              .shadow(color: Color.lineColor(viewState.movieCard.voteAverage), radius: 5, x: 0, y: 0)
              .overlay(
                Text("\(Int(viewState.movieCard.voteAverage * 100))%")
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
          ForEach(viewState.movieCard.genreList, id: \.self) { genre in
            Button(action: { print(genre) }) {
              Text(genre)
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
        .padding(.leading, 8)
        .padding(.vertical, 8)
      }
      Spacer()
    }
    .padding(.horizontal, 8)
    .background(Color(.systemBlue).opacity(0.7))
  }
}

// MARK: - MovieDetailPage.MovieCardComponent.ViewState

extension MovieDetailPage.MovieCardComponent {
  struct ViewState: Equatable {
    let movieCard: MovieItem
  }
}

// MARK: - MovieDetailPage.MovieCardComponent.ViewState.MovieItem

extension MovieDetailPage.MovieCardComponent.ViewState {
  struct MovieItem: Equatable, Identifiable {
    let id = UUID()
    //    let image
    let releaseDate: String
    let runningTime: Int
    let releasedCountry: String
    let voteAverage: Double
    let voteCounts: Int
    let genreList: [String]
  }
}
