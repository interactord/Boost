import Architecture
import ComposableArchitecture
import Foundation
import SwiftUI

// MARK: - MyListsPage

struct MyListsPage {

  private let store: StoreOf<MyListsStore>
  @ObservedObject private var viewStore: ViewStoreOf<MyListsStore>

  init(store: StoreOf<MyListsStore>) {
    self.store = store
    viewStore = ViewStore(store, observe: { $0 })
  }
}

// MOCK 데이터 생성
extension MyListsPage {
  private var customListsComponentViewState: CustomListsComponent.ViewState {
    .init(placeHolder: "Create custom list")
  }

  private var wishListsComponentViewState: WishListsComponent.ViewState {
    .init(
      text: "(선택한 무비 개수) MOVIES IN WISHLIST (BY RELEASE DATE)",
      seenList: [
        WishListsComponent.ViewState.MovieItem(
          title: "더넌 2",
          voteAverage: 0.67,
          releaseDate: "9/6/23",
          overView: "1956년, 프랑스의 한 성당에서 신부가 끔찍하게 살해당한다. 이 사건을 조사하기 위해 파견된 아이린 수녀는 4년 전 자신을 공포에 떨게 했던 악마의 기운을 느낀다. 어두은 밤, 계속해서 일어나는 의문의 사건들 가운데 충격적인 진실이 드러나는데..."),

        WishListsComponent.ViewState.MovieItem(
          title: "스트레이즈",
          voteAverage: 0.74,
          releaseDate: "8/18/23",
          overView: ""),

        WishListsComponent.ViewState.MovieItem(
          title: "데메테르호의 마지막 항해",
          voteAverage: 0.73,
          releaseDate: "8/9/23",
          overView: "브램 스토커의 소설인 <드라큘라> 중 한 에피소드를 영화화하는 작품으로 드라큘라의 관을 싣고 가던 영국 배의 선원들이 차례로 사라지는 공포스러운 상황에 관한 이야기"),
      ])
  }

  private var seenListsComponentViewState: SeenListsComponent.ViewState {
    .init(
      text: "(선택한 무비 개수) MOVIES IN SEENLIST (BY RELEASE DATE)",
      wishtList: [])
  }
}

// MARK: View

extension MyListsPage: View {
  var body: some View {
    ScrollView {
      VStack {
        // CUSTOM Lists
        CustomListsComponent(viewState: customListsComponentViewState)
          .padding(.vertical, 20)

        // MY Lists
        Group {
          Picker("", selection: viewStore.$listFocus) {
            Text("Wishlist").tag(MyListsStore.State.ListType.wish)
            Text("Seenlist").tag(MyListsStore.State.ListType.seen)
          }
          .pickerStyle(SegmentedPickerStyle())
          .font(.callout)
          .foregroundColor(.customGreenColor)
          .frame(minHeight: 40)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 16)
          .background(Color.white)

          switch viewStore.listFocus {
          case .wish:
            WishListsComponent(viewState: wishListsComponentViewState)

          case .seen:
            SeenListsComponent(viewState: seenListsComponentViewState)
          }
        }

        Spacer()
      }
      .navigationTitle("My Lists")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: { }) {
            Image(systemName: "line.3.horizontal.decrease.circle")
              .resizable()
              .foregroundColor(.customYellowColor)
          }
        }
      }
    }
    .background(Color.customBgColor)
  }
}
