import Foundation
import SwiftUI
import Domain

extension MovieDetailPage {
  struct KeywordListComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.KeywordListComponent {
}

extension MovieDetailPage.KeywordListComponent: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("Keywords")
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack {
          ForEach(viewState.keywordList, id: \.id) { item in
            Button(action: { }) {
              HStack {
                Text(item.name)
                  .font(.footnote)
                  
                Image(systemName: "chevron.right")
                  .resizable()
                  .frame(width: 6, height: 8)
              }
              .foregroundColor(Color(.label))
              .padding(4)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(Color.customBgColor)
              )
            }
          }
        }
      }
    }
    .padding(.vertical)
    .padding(.horizontal, 12)
  }
}

extension MovieDetailPage.KeywordListComponent {
  struct ViewState: Equatable {
    let keywordList: [KeywordItem]
    
    init(rawValue: MovieDetailDomain.Response.KeywordBucket?) {
      keywordList = (rawValue?.keywordList ?? []).map(KeywordItem.init(rawValue:))
    }
  }
}

extension MovieDetailPage.KeywordListComponent.ViewState {
  struct KeywordItem: Equatable, Identifiable {
    let id: Int
    let name: String
    
    init(rawValue: MovieDetailDomain.Response.KeywordItem) {
      id = rawValue.id
      name = rawValue.name
    }
  }
}
