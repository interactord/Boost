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
  ],
  targets: [
    .target(
      name: "Architecture",
      dependencies: []),
    .testTarget(
      name: "ArchitectureTests",
      dependencies: ["Architecture"]),
  ]
)
