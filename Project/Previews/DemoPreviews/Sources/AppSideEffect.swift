import Architecture
import Demo
import Foundation
import LinkNavigator

// MARK: - AppSideEffect

public struct AppSideEffect {
  public init() { }
}

// MARK: DemoSideEffectGroup

extension AppSideEffect: DemoSideEffectGroup { }
