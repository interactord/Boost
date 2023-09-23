import Foundation
import SwiftUI
import Domain

extension MovieDetailPage {
  struct OtherPosterListComponent {
    let viewState: ViewState
  }
}


extension MovieDetailPage.OtherPosterListComponent {
}

extension MovieDetailPage.OtherPosterListComponent: View {
  var body: some View {
    VStack {
      HStack {
        Text("Other posters")
        Spacer()
      }
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 36) {
          ForEach(viewState.itemList.prefix(8), id: \.image) { item in
            Asset.spongeBob.swiftUIImage
              .resizable()
              .frame(width: 100, height: 160)
              .clipShape(RoundedRectangle(cornerRadius: 10))
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(.black, lineWidth: 1)
              )
              .shadow(radius: 10)
          }
        }
      }
    }
    .padding(.vertical)
    .padding(.horizontal, 16)
  }
}

extension MovieDetailPage.OtherPosterListComponent {
  struct ViewState: Equatable {
    let itemList: [ImageItem]
    
    init(rawValue: MovieDetailDomain.Response.ImageBucket?) {
      itemList = (rawValue?.posterList ?? []).map(ImageItem.init(rawValue:))
    }
  }
}

extension MovieDetailPage.OtherPosterListComponent.ViewState {
  struct ImageItem: Equatable {
    let image: String
    
    init(rawValue: MovieDetailDomain.Response.PosterItem) {
      image = rawValue.poster ?? ""
    }
  }
}
