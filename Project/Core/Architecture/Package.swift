// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Architecture",
  platforms: [
    .iOS(.v16),
  ],
  products: [
    .library(
      name: "Architecture",
      targets: ["Architecture"]),
  ],
  dependencies: [
    .package(path: "../Domain"),
    .package(path: "../Platform"),
    .package(
      url: "https://github.com/interactord/LinkNavigator",
      branch: "feature"),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      .upToNextMajor(from: "1.2.0")),
  ],
  targets: [
    .target(
      name: "Architecture",
      dependencies: [
      "Domain",
      "Platform",
      "LinkNavigator",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]),
    .testTarget(
      name: "ArchitectureTests",
      dependencies: ["Architecture"]),
  ]
)
