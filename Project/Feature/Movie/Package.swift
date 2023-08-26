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
  ],
  targets: [
    .target(
      name: "Movie",
      dependencies: [
        "Architecture",
      ]),
    .testTarget(
      name: "MovieTests",
      dependencies: ["Movie"]),
  ])
