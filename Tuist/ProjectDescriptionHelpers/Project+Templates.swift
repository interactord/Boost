import Foundation
import ProjectDescription

extension Target {
  static func previewTarget(
    projectName: String,
    dependencies: [TargetDependency])
    -> Self
  {
    .init(
      name: "\(projectName)Preview",
      platform: .iOS,
      product: .app,
      bundleId: "com.myCompany.\(projectName.lowercased()).preview",
      deploymentTarget: .defaultTarget,
      infoPlist: .extendingDefault(with: infoValue),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: .relativeToRoot("Entitlements/Preview.entitlements"),
      dependencies: dependencies,
      settings: .defaultConfigSettings)
  }

  static func previewTestTarget(projectName: String) -> Self {
    .init(
      name: "\(projectName)PreviewTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.myCompany.\(projectName.lowercased()).preview.tests",
      deploymentTarget: .defaultTarget,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: "\(projectName)Preview"),
      ],
      settings: .defaultConfigSettings)
  }
}

extension Collection<Scheme> {

  public static func testScheme(previewTestTarget: String) -> [Scheme] {
    [
      .init(
        name: "\(previewTestTarget)Preview",
        shared: true,
        hidden: false,
        buildAction: .init(targets: ["\(previewTestTarget)Preview"]),
        testAction: .targets(["\(previewTestTarget)PreviewTests"])),
    ]
  }
}

extension Settings {
  public static let defaultConfigSettings: Settings = .settings(
    base: [
      "CODE_SIGN_IDENTITY": "iPhone Developer",
      "CODE_SIGN_STYLE": "Automatic",
      "DEVELOPMENT_TEAM": "DEVELOPMENT_TEAM",
    ], configurations: [], defaultSettings: .recommended)
}

extension Project {

  public static func previewProject(
    projectName: String,
    packages: [Package],
    dependencies: [TargetDependency])
    -> Self
  {
    .init(
      name: "\(projectName)Preview",
      organizationName: "myCompany",
      packages: packages,
      targets: [
        .previewTarget(projectName: projectName, dependencies: dependencies),
        .previewTestTarget(projectName: projectName),
      ],
      schemes: .testScheme(previewTestTarget: projectName))
  }
}

public var infoValue: [String: InfoPlist.Value] {
  defaultInfoValue
    .merging(customPropertyInfoValue) { $1 }
}

var defaultInfoValue: [String: InfoPlist.Value] {
  [
    "CFBundleDevelopmentRegion": .string("$(DEVELOPMENT_LANGUAGE)"),
    "CFBundleDisplayName": .string("${PRODUCT_NAME}"),
    "CFBundleShortVersionString": .string(.appVersion()),
    "CFBundleVersion": .string(.appBuildVersion()),
    "LSHasLocalizedDisplayName": .boolean(true),
    "UIApplicationSupportsMultipleScenes": .boolean(false),
    "UISupportedInterfaceOrientations": .array([
      .string("UIInterfaceOrientationPortrait"),
    ]),
    "LSRequiresIPhoneOS": .boolean(true),
    "UIApplicationSceneManifest": .dictionary([
      "UIApplicationSupportsMultipleScenes": .boolean(true),
    ]),
    "UIApplicationSupportsIndirectInputEvents": .boolean(true),
    "UILaunchScreen": .dictionary([:]),
    "UISceneConfigurations": .dictionary([
      "UIApplicationSupportsMultipleScenes": .boolean(false),
      "UISceneConfigurations": .dictionary([
        "UIWindowSceneSessionRoleApplication": .array([.dictionary([
          "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
        ])]),
      ]),
    ]),
    "ITSAppUsesNonExemptEncryption": .boolean(false),
    "NSAppTransportSecurity": .dictionary([
      "NSAllowsArbitraryLoads": .boolean(true),
    ]),
  ]
}

var customPropertyInfoValue: [String: InfoPlist.Value] {
  [
    "Mode": .string("$(MODE)"),
  ]
}

extension String {

  public static func appVersion() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy.MM.dd"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: Date())
  }

  public static func appBuildVersion() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMddHHmmsss"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: Date())
  }
}
