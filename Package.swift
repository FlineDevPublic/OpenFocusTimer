// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "OpenFocusTimer",
  platforms: [.macOS(.v12), .iOS(.v15)],

  products: [
    .library(name: "AppEntryPoint", targets: ["AppEntryPoint"]),
    .library(name: "Model", targets: ["Model"]),
  ],
  dependencies: [
    // A library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind.
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.33.1")
  ],
  targets: [
    .target(
      name: "AppEntryPoint",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Model",
      ]
    ),
    .target(
      name: "Model",
      dependencies: [],
      resources: [
        .process("Model.xcdatamodeld")
      ]
    ),
  ]
)
