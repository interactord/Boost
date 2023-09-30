import Domain
import Foundation
import SwiftUI

// MARK: - SimilarMoviePage.ItemListComponent

extension SimilarMoviePage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

// MARK: - SimilarMoviePage.ItemListComponent + View

extension SimilarMoviePage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewState.itemList) { item in
          ItemComponent(item: item)
            .background(.white)
        }
      }
    }
  }
}

// MARK: - SimilarMoviePage.ItemListComponent.ViewState

extension SimilarMoviePage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [SimilarMovieItem]

    init(rawValue: [MovieDetailDomain.Response.SimilarMovieResultItem]) {
      itemList = rawValue.map(SimilarMovieItem.init(rawValue:))
    }
  }
}

// MARK: - SimilarMoviePage.ItemListComponent.ViewState.SimilarMovieItem

extension SimilarMoviePage.ItemListComponent.ViewState {
  struct SimilarMovieItem: Equatable, Identifiable {
    let id: Int
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let overView: String
    let rawValue: MovieDetailDomain.Response.SimilarMovieResultItem

    init(rawValue: MovieDetailDomain.Response.SimilarMovieResultItem) {
      id = rawValue.id
      title = rawValue.title
      voteAverage = rawValue.voteAverage
      releaseDate = rawValue.releaseDate
      overView = rawValue.overview
      self.rawValue = rawValue
    }
  }
}

// MARK: - SimilarMoviePage.ItemListComponent.ItemComponent

extension SimilarMoviePage.ItemListComponent {
  fileprivate struct ItemComponent {
    let item: ViewState.SimilarMovieItem
  }
}

// MARK: - SimilarMoviePage.ItemListComponent.ItemComponent + View

extension SimilarMoviePage.ItemListComponent.ItemComponent: View {
  var body: some View {
    VStack {
      HStack(spacing: 16) {
        Asset.spongeBob.swiftUIImage
          .resizable()
          .frame(width: 100, height: 140)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(.black, lineWidth: 1))
          .shadow(radius: 10)

        VStack(alignment: .leading, spacing: 8) {
          Text(item.title)
            .font(.headline)
            .fontWeight(.regular)
            .foregroundColor(.customYellowColor)

          HStack {
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

            Text(item.releaseDate.formatDate())
              .font(.subheadline)
          }

          Text(item.overView)
            .font(.callout)
            .foregroundColor(Color.gray)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
        }

        Spacer()

        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 12)
          .foregroundColor(Color(.gray))
          .padding(.trailing, 16)
      } // Hstack
      .padding(.vertical, 8)

      Divider()
        .padding(.leading, 144)
    }
  }
}

extension String {
  fileprivate func formatDate() -> Self {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    if let date = dateFormatter.date(from: self) {
      dateFormatter.dateFormat = "M/d/yy"
      return dateFormatter.string(from: date)
    } else {
      return "날짜 형식 오류"
    }
  }
}
