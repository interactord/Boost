// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Demo",
  platforms: [
    .iOS(.v16),
  ],
  products: [
    .library(
      name: "Demo",
      targets: ["Demo"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Demo"),
    .testTarget(
      name: "DemoTests",
      dependencies: ["Demo"]),
  ])
