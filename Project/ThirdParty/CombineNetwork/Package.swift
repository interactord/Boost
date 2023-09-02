// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CombineNetwork",
  platforms: [ .iOS(.v15) ],
  products: [
    .library(
      name: "CombineNetwork",
      targets: ["CombineNetwork"]),
  ],
  dependencies: [
    .package(url: "https://github.com/interactord/URLEncodedForm", .upToNextMajor(from: "1.0.0")),
  ],
  targets: [
    .target(
      name: "CombineNetwork",
      dependencies: [
        "URLEncodedForm",
      ]),
    .testTarget(
      name: "CombineNetworkTests",
      dependencies: ["CombineNetwork"]),
  ]
)
