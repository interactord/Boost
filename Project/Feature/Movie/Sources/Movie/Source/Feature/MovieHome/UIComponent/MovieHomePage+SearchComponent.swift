import Architecture
import Foundation
import SwiftUI
import Combine

extension MovieHomePage {
  struct SearchComponent {

    @StateObject private var textBindingObserver: BindingObserver<String> = .init()

    let viewState: ViewState
    let keyword: Binding<String>
    let throttleAction: () -> Void
    let clearAction: () -> Void
  }
}

extension MovieHomePage.SearchComponent: View {
  var body: some View {
    HStack(spacing: 8) {
      Image(systemName: "magnifyingglass")
        .resizable()
        .frame(width: 16, height: 16)
        .padding(8)

      TextField(viewState.placeHolder, text: keyword)
        .textFieldStyle(RoundedBorderTextFieldStyle())

      if !keyword.wrappedValue.isEmpty {
        Button.init(action: { keyword.wrappedValue = "" }) {
          Text("Cancel")
        }
      }
    }
    .onChange(of: keyword.wrappedValue) { textBindingObserver.update(value: $0) }
    .onChange(of: keyword.wrappedValue) {
      guard $0.isEmpty else { return }
      clearAction()
    }
    .onReceive(
      textBindingObserver.$value
        .throttle(for: .milliseconds(500), scheduler: RunLoop.main, latest: true))
    { _ in throttleAction() }

  }
}

extension MovieHomePage.SearchComponent {
  struct ViewState: Equatable {
    let placeHolder: String
  }
}
