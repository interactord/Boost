import Foundation
import SwiftUI

// MARK: - MovieHomePage.SearchResultMoviesComponenet

extension MovieHomePage {
  struct SearchResultMoviesComponent {
    let viewState: ViewState
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
      }) {
        if !viewState.keywordList.isEmpty {
          ForEach(viewState.keywordList, id: \.self) { keyword in
            Divider()
            HStack {
              Text(keyword)
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
      .padding(.vertical, 16)
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

        Divider()
      }) {
        if viewState.itemList.isEmpty {
          Text("No results")
            .font(.callout)

          Divider()
        }
        else {
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
    // 검색 했을때 맞는 키워드가 없으면 keywords에는 header만 나오고, Result 부분은 "No results" 가 나오도록 해야됌 => 현재는 list가 비어있을때로 설정함 (레이아웃 먼저 잡기 위해)
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
    let keywordList: [String]
  }
}

// MARK: - MovieHomePage.SearchResultMoviesComponent.ViewState.MovieItem

extension MovieHomePage.SearchResultMoviesComponent.ViewState {
  struct MovieItem: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let overView: String
  }
}
