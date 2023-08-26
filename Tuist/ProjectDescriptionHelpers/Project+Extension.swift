import ProjectDescription

extension DeploymentTarget {
  public static let defaultTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: [.iphone, .ipad])
}

extension String {
  public static let marketVersion = "MARKETING_VERSION"
  public static let codeSignIdentity = "CODE_SIGN_IDENTITY"
  public static let codeSigningStyle = "CODE_SIGNING_STYLE"
  public static let codeSigningRequired = "CODE_SIGNING_REQUIRED"
  public static let developmentTeam = "DEVELOPMENT_TEAM"
  public static let provisioningProfileSpecifier = "PROVISIONING_PROFILE_SPECIFIER"
  public static let swiftVersion = "SWIFT_VERSION"
  public static let developmentAssetPaths = "DEVELOPMENT_ASSET_PATHS"
  public static let enableTestability = "ENABLE_TESTABILITY"
}
