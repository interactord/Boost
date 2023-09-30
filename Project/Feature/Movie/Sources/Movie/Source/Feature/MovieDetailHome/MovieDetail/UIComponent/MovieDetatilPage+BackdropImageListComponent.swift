import Domain
import Foundation
import SwiftUI

// MARK: - MovieDetailPage.BackdropImageListComponent

extension MovieDetailPage {
  struct BackdropImageListComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.BackdropImageListComponent { }

// MARK: - MovieDetailPage.BackdropImageListComponent + View

extension MovieDetailPage.BackdropImageListComponent: View {
  var body: some View {
    VStack {
      HStack {
        Text("Images")
        Spacer()
      }
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(spacing: 20) {
          ForEach(viewState.itemList, id: \.image) { _ in
            Asset.spongeBob.swiftUIImage
              .resizable()
              .frame(width: 240, height: 160)
              .overlay(
                Rectangle()
                  .stroke(Color.black, lineWidth: 2))
          }
        }
      }
    }
    .padding(.vertical)
    .padding(.horizontal, 16)
  }
}

// MARK: - MovieDetailPage.BackdropImageListComponent.ViewState

extension MovieDetailPage.BackdropImageListComponent {
  struct ViewState: Equatable {
    let itemList: [ImageItem]

    init(rawValue: MovieDetailDomain.Response.ImageBucket?) {
      itemList = (rawValue?.backdropList ?? []).map(ImageItem.init(rawValue:))
    }
  }
}

// MARK: - MovieDetailPage.BackdropImageListComponent.ViewState.ImageItem

extension MovieDetailPage.BackdropImageListComponent.ViewState {
  struct ImageItem: Equatable {
    let image: String

    init(rawValue: MovieDetailDomain.Response.BackdropItem) {
      image = rawValue.backdropImage ?? ""
    }
  }
}
