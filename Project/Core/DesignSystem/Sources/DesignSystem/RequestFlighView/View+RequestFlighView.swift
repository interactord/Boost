import SwiftUI

extension View {

  @ViewBuilder
  public func setRequestFlightView(isLoading: Bool) -> some View {
    self
      .overlay(alignment: .center) {
        if isLoading {
          Rectangle()
            .fill(.clear)
            .background(.black.opacity(0.13))
            .overlay(
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle.circular)
            )
        }
      }
  }
}

