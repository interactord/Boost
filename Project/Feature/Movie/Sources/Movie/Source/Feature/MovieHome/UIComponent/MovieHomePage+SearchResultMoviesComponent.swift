import Domain
import Foundation
import SwiftUI

// MARK: - MovieHomePage.SearchResultMoviesComponent

extension MovieHomePage {
  struct SearchResultMoviesComponent {
    let viewState: ViewState
  }
}

extension MovieHomePage.SearchResultMoviesComponent {
  private func formatDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    if let date = dateFormatter.date(from: dateString) {
      dateFormatter.dateFormat = "M/d/yy"
      return dateFormatter.string(from: date)
    } else {
      return "날짜 형식 오류"
    }
  }
}

// MARK: - MovieHomePage.SearchResultMoviesComponent + View

extension MovieHomePage.SearchResultMoviesComponent: View {

  @ViewBuilder
  var keywordSection: some View {
    Section(
      header:
      VStack(alignment: .leading, spacing: 2) {
        Text("Keywords")
          .font(.subheadline)
          .fontWeight(.semibold)
          .foregroundColor(Color.gray)
          .padding(.top, 16)
      }) {
        if !viewState.keywordList.isEmpty {
          ForEach(viewState.keywordList, id: \.id) { item in
            Divider()
            HStack {
              Text(item.name)
                .font(.subheadline)

              Spacer()

              Image(systemName: "chevron.forward")
                .resizable()
                .frame(width: 8, height: 8)
                .foregroundColor(Color(.gray))
                .padding(.trailing, 16)
            }
          }
        }
      }
  }

  @ViewBuilder
  var resultSection: some View {
    Section(
      header:
      VStack(alignment: .leading, spacing: 2) {
        Text("Results for (키워드에 입력한 것이 나오도록)")
          .font(.subheadline)
          .fontWeight(.semibold)
          .foregroundColor(Color.gray)
          .padding(.top, 16)

        Divider()
      }) {
        if viewState.itemList.isEmpty {
          Text("No results")
            .font(.callout)

          Divider()

        } else {
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
                  .foregroundColor(Color(red: 0.85, green: 0.75, blue: 0.05))

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

                  Text(formatDate(item.releaseDate))
                    .font(.subheadline)
                }

                Text(item.overView)
                  .font(.body)
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

            Divider()
              .padding(.leading, 144)
          }
        }
      }
  }

  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        keywordSection
        resultSection
      }
    }
  }
}

// MARK: - MovieHomePage.SearchResultMoviesComponent.ViewState

extension MovieHomePage.SearchResultMoviesComponent {
  struct ViewState: Equatable {
    let itemList: [MovieItem]
    let keywordList: [KeywordItem]

    init(
      fetchSearchMovie: SearchDomain.Response.MovieResult?,
      fetchSearchKeyword: SearchDomain.Response.KeywordResult?)
    {
      itemList = (fetchSearchMovie?.resultList ?? []).map(MovieItem.init(rawValue:))
      keywordList = (fetchSearchKeyword?.resultList ?? []).map(KeywordItem.init(rawValue:))
    }
  }
}

extension MovieHomePage.SearchResultMoviesComponent.ViewState {
  struct MovieItem: Equatable, Identifiable {
    let id: Int
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let overView: String

    init(rawValue: SearchDomain.Response.MovieResultItem) {
      id = rawValue.id
      title = rawValue.title
      voteAverage = rawValue.voteAverage
      releaseDate = rawValue.releaseDate
      overView = rawValue.overview
    }
  }

  struct KeywordItem: Equatable, Identifiable {
    let id: Int
    let name: String

    init(rawValue: SearchDomain.Response.KeywordResultItem) {
      id = rawValue.id
      name = rawValue.name
    }
  }
}
