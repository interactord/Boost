import Foundation
import SwiftUI

extension MovieDetailPage {
  struct ListButtonComponent {
    let viewState: ViewState
  }
}

extension MovieDetailPage.ListButtonComponent {
  

}

extension MovieDetailPage.ListButtonComponent: View {
  var body: some View {
    HStack {    
//      Text(viewState.text)
      Button(action: { }) {
        HStack {
          Image(systemName: "heart")
            .resizable()
            .frame(width: 15, height: 15)
          
          Text("Wishlist")
        }
        .padding(4)
        .background(
          RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1)
        )
      }
      
      Button(action: { }) {
        HStack {
          Image(systemName: "eye")
            .resizable()
            .frame(width: 20, height: 15)
          
          Text("SeenList")
        }
        .padding(4)
        .background(
          RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1)
        )
      }

      Button(action: { }) {
        HStack {
          Image(systemName: "pin")
            .resizable()
            .frame(width: 10, height: 15)
          
          Text("List")
        }
        .padding(4)
        .background(
          RoundedRectangle(cornerRadius: 5)
            .stroke(lineWidth: 1)
        )
      }
      
      Spacer()
    }
    .padding(.leading, 16)
  }
}

extension MovieDetailPage.ListButtonComponent {
  struct ViewState: Equatable {
    let text: String
  }
}
