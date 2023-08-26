import BoostKit
import BoostUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil)
    -> Bool
  {
    window = UIWindow(frame: UIScreen.main.bounds)
    let viewController = UIViewController()
    viewController.view.backgroundColor = .white
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()

    BoostKit.hello()
    BoostUI.hello()

    return true
  }

}
