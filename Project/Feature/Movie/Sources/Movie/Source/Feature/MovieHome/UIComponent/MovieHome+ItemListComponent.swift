import Domain
import Foundation
import SwiftUI

// MARK: - MovieHomePage.ItemListComponent

extension MovieHomePage {
  struct ItemListComponent {
    let viewState: ViewState
    let nextPageAction: () -> Void
    let selectAction: (MovieDomain.MovieList.Response.ResultItem) -> Void
  }
}

// MARK: - MovieHomePage.ItemListComponent + View

extension MovieHomePage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewState.itemList) { item in
          ItemComponent(item: item)
            .background(.white)
            .onTapGesture {
              selectAction(item.rawValue)
            }
            .onAppear {
              print("AAA ", item.imageURL)
            }
            .onAppear {
              guard viewState.lastID == item.id else { return }
              nextPageAction()
            }
        }
      }
    }
    .onAppear {
      print("MovieHomePage.ItemListComponent onAppear")
    }
    .onDisappear {
      print("MovieHomePage.ItemListComponent onDisappear")
    }
  }
}

// MARK: - MovieHomePage.ItemListComponent.ViewState

extension MovieHomePage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [MovieItem]
    let lastID: Int

    init(rawValue: [MovieHomeStore.State.ResultItemScope]) {
      itemList = rawValue.map(MovieItem.init(rawValue:))
      lastID = rawValue.last?.id ?? .zero
    }
  }
}

// MARK: - MovieHomePage.ItemListComponent.ViewState.MovieItem

extension MovieHomePage.ItemListComponent.ViewState {
  struct MovieItem: Equatable, Identifiable {
    let id: Int
    let title: String
    let imageURL: String
    let voteAverage: Double
    let releaseDate: String
    let overView: String
    let rawValue: MovieDomain.MovieList.Response.ResultItem

    init(rawValue: MovieHomeStore.State.ResultItemScope) {
      id = rawValue.id
      imageURL = rawValue.imageURL + rawValue.item.posterPath
      title = rawValue.item.title
      voteAverage = rawValue.item.voteAverage
      releaseDate = rawValue.item.releaseDate
      overView = rawValue.item.overview
      self.rawValue = rawValue.item
    }
  }
}

extension Color {

  // MARK: Public

  public static var customYellowColor = Color(red: 0.75, green: 0.6, blue: 0.2)

  public static var customGreenColor = Color(red: 0.45, green: 0.64, blue: 0.62)

  public static var customBgColor = Color(red: 0.94, green: 0.94, blue: 0.96)

  // MARK: Internal

  static func lineColor(_ voteAverage: Double) -> Color {
    if voteAverage >= 7.5 {
      return .green
    } else if voteAverage >= 5.0 {
      return .yellow
    } else {
      return .red
    }
  }
}

// MARK: - MovieHomePage.ItemListComponent.ItemComponent

extension MovieHomePage.ItemListComponent {
  fileprivate struct ItemComponent {
    let item: ViewState.MovieItem
  }
}

// MARK: - MovieHomePage.ItemListComponent.ItemComponent + View

extension MovieHomePage.ItemListComponent.ItemComponent: View {
  var body: some View {
    VStack {
      HStack(spacing: 16) {
        AsyncImage(
          url: .init(string: item.imageURL),
          content: { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
          }, placeholder: {
            Rectangle()
              .fill(.gray)
              .frame(width: 90)
          })
          .frame(height: 140)
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
