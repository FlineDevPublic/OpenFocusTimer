// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "OpenFocusTimer",
  defaultLocalization: "en",
  platforms: [.macOS(.v12), .iOS(.v15)],

  products: [
    .library(name: "AppEntryPoint", targets: ["AppEntryPoint"]),
    .library(name: "Model", targets: ["Model"]),
    .library(name: "TimerFeature", targets: ["TimerFeature"]),
    .library(name: "Resources", targets: ["Resources"]),
  ],
  dependencies: [
    // A library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind.
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.33.1"),

    // Safely access Apple's SF Symbols using static typing Topics
    .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols", from: "2.1.3"),
  ],
  targets: [
    .target(
      name: "AppEntryPoint",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Model",
        "TimerFeature",
      ]
    ),
    .target(
      name: "Model",
      dependencies: [],
      resources: [
        .process("Model.xcdatamodeld")
      ]
    ),
    .target(
      name: "TimerFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Model",
        "Resources",
        .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
      ]
    ),
    .target(
      name: "Resources",
      resources: [
        .process("Localizable")
      ]
    ),
  ]
)
