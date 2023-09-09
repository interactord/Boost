// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Movie",
  platforms: [
    .iOS(.v16),
  ],
  products: [
    .library(
      name: "Movie",
      targets: ["Movie"]),
  ],
  dependencies: [
    .package(path: "../../Core/Architecture"),
    .package(path: "../../Core/DesignSystem"),
  ],
  targets: [
    .target(
      name: "Movie",
      dependencies: [
        "Architecture",
        "DesignSystem",
      ]),
    .testTarget(
      name: "MovieTests",
      dependencies: ["Movie"]),
  ])
