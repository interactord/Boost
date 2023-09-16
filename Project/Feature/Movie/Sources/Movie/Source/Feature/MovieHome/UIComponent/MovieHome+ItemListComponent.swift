import Foundation
import SwiftUI

// MARK: - MovieHomePage.ItemListComponent

extension MovieHomePage {
  struct ItemListComponent {
    let viewState: ViewState
  }
}

// MARK: - MovieHomePage.ItemListComponent + View

extension MovieHomePage.ItemListComponent: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewState.itemList) { item in

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
                  .trim(from: 0, to: 0.75)
                  .stroke(
                    style: StrokeStyle(lineWidth: 2, dash: [1, 1.5]))
                  .rotationEffect(.degrees(-90))
                  .frame(width: 40, height: 40)
                  .foregroundColor(Color.lineColor(item.voteAverage))
                  .shadow(color: Color.lineColor(item.voteAverage), radius: 5, x: 0, y: 0)
                  .overlay(
                    Text("\(Int(item.voteAverage * 100))%")
                      .font(.system(size: 10)))

                Text(item.releaseDate)
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
  }
}

// MARK: - MovieHomePage.ItemListComponent.ViewState

extension MovieHomePage.ItemListComponent {
  struct ViewState: Equatable {
    let itemList: [MovieItem]
  }
}

// MARK: - MovieHomePage.ItemListComponent.ViewState.MovieItem

extension MovieHomePage.ItemListComponent.ViewState {
  struct MovieItem: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let overView: String
  }
}

extension Color {

  // MARK: Public

  public static var customYellowColor = Color(red: 0.75, green: 0.6, blue: 0.2)

  public static var customGreenColor = Color(red: 0.45, green: 0.64, blue: 0.62)

  public static var customBgColor = Color(red: 0.94, green: 0.94, blue: 0.96)

  // MARK: Internal

  static func lineColor(_ voteAverage: Double) -> Color {
    if voteAverage >= 0.75 {
      return .green
    } else if voteAverage >= 0.50 {
      return .yellow
    } else {
      return .red
    }
  }
}
