// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Platform",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "Platform",
      targets: ["Platform"]),
  ],
  dependencies: [
    .package(path: "../../ThirdParty/CombineNetwork"),
  ],
  targets: [
    .target(
      name: "Platform",
      dependencies: [
        "CombineNetwork",
      ]),
    .testTarget(
      name: "PlatformTests",
      dependencies: ["Platform"]),
  ])
