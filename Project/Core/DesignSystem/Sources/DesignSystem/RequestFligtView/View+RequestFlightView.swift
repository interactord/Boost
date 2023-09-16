import SwiftUI

extension View {

  @ViewBuilder
  public func setRequestFlightView(isLoading: Bool) -> some View {
    if isLoading {
      self
        .overlay(alignment: .center) {
          Rectangle()
            .fill(.clear)
            .background(.black.opacity(0.13))
            .overlay(
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle.circular)
            )
        }
    } else {
      self
    }
  }
}
