import Foundation
import SwiftUI
import Domain

extension MovieDetailPage {
  struct RecommendedMovieListComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.RecommendedMovieListComponent {
}

extension MovieDetailPage.RecommendedMovieListComponent: View {
  var body: some View {
    VStack {
      HStack {
        Text("Recommended Movies")
        Text("See all")
          .foregroundColor(.customGreenColor)
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 10)
      }
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 48) {
          ForEach(viewState.itemList, id: \.id) { item in
            Button(action: { }) {
              VStack {
                Asset.spongeBob.swiftUIImage
                  .resizable()
                  .frame(width: 100, height: 160)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  .overlay(
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(.black, lineWidth: 1)
                  )
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
                  .shadow(color:Color.lineColor(item.voteAverage), radius: 5, x: 0, y: 0)
                  .overlay (
                    Text("\(Int(item.voteAverage * 10))%")
                      .font(.system(size: 10))
                  )
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

extension MovieDetailPage.RecommendedMovieListComponent {
  struct ViewState: Equatable {
    let itemList: [RecommendedMovieItem]
    
    init(rawValue: MovieDetailDomain.Response.RecommenededMovieResult?) {
      itemList = (rawValue?.resultList ?? []).map(RecommendedMovieItem.init(rawValue:))
    }
  }
}

extension MovieDetailPage.RecommendedMovieListComponent.ViewState {
  struct RecommendedMovieItem: Equatable, Identifiable {
    let id: Int
    let title: String
    let voteAverage: Double
    
    init(rawValue: MovieDetailDomain.Response.RecommenededMovieResultItem) {
      id = rawValue.id
      title = rawValue.title
      voteAverage = rawValue.voteAverage
    }
  }
}

