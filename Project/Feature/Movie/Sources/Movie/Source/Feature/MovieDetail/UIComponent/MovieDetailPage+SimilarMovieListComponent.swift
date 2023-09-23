import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.SimilarMovieListComponent

extension MovieDetailPage {
  struct SimilarMovieListComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.SimilarMovieListComponent { }

// MARK: - MovieDetailPage.SimilarMovieListComponent + View

extension MovieDetailPage.SimilarMovieListComponent: View {
  var body: some View {
    VStack {
      HStack {
        Text("Similar Movies")
        Text("See all")
          .foregroundColor(.customGreenColor)

        Spacer()

        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 10)
      }

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 24) {
          ForEach(viewState.itemList, id: \.id) { item in
            Button(action: { }) {
              VStack {
                Asset.spongeBob.swiftUIImage
                  .resizable()
                  .frame(width: 100, height: 140)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(.black, lineWidth: 1))
                  .shadow(radius: 10)

                Text(item.title)
                  .font(.footnote)

                Circle()
                  .trim(from: 0, to: item.voteAverage / 10)
                  .stroke(
                    style: StrokeStyle(lineWidth: 2, dash: [1, 1.5]))
                  .rotationEffect(.degrees(-90))
                  .frame(width: 40, height: 40)
                  .foregroundColor(Color.lineColor(item.voteAverage))
                  .shadow(color: Color.lineColor(item.voteAverage), radius: 5, x: 0, y: 0)
                  .overlay(
                    Text("\(Int(item.voteAverage * 10))%")
                      .font(.system(size: 10)))
              }
            }
            .foregroundColor(Color(.label))
            .frame(width: 120)
            .lineLimit(0)
          }
        }
      }
    }
    .padding(.vertical)
    .padding(.horizontal, 16)
  }
}

// MARK: - MovieDetailPage.SimilarMovieListComponent.ViewState

extension MovieDetailPage.SimilarMovieListComponent {
  struct ViewState: Equatable {
    let itemList: [SimilarMovieItem]

    init(rawValue: MovieDetailDomain.Response.SimilarMovieResult?) {
      itemList = (rawValue?.resultList ?? []).map(SimilarMovieItem.init(rawValue:))
    }
  }
}

// MARK: - MovieDetailPage.SimilarMovieListComponent.ViewState.SimilarMovieItem

extension MovieDetailPage.SimilarMovieListComponent.ViewState {
  struct SimilarMovieItem: Equatable, Identifiable {
    let id: Int
    let title: String
    let voteAverage: Double

    init(rawValue: MovieDetailDomain.Response.SimilarMovieResultItem) {
      id = rawValue.id
      title = rawValue.title
      voteAverage = rawValue.voteAverage
    }
  }
}
