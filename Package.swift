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
    .library(name: "ReflectionFeature", targets: ["ReflectionFeature"]),
    .library(name: "Resources", targets: ["Resources"]),
  ],
  dependencies: [
    // Commonly used data structures for Swift
    .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),

    // Handy Swift features that didn't make it into the Swift standard library.
    .package(url: "https://github.com/Flinesoft/HandySwift", from: "3.4.0"),

    // Handy SwiftUI features that didn't make it into the SwiftUI (yet).
    .package(url: "https://github.com/Flinesoft/HandySwiftUI", .branch("main")),

    // A library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind.
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.33.1"),

    // Safely access Apple's SF Symbols using static typing Topics
    .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols", from: "2.1.3"),

    // ⏰ A few schedulers that make working with Combine more testable and more versatile.
    .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.5.3"),
  ],
  targets: [
    .target(
      name: "AppEntryPoint",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "HandySwift", package: "HandySwift"),
        .product(name: "HandySwiftUI", package: "HandySwiftUI"),
        "Model",
        "ReflectionFeature",
        "TimerFeature",
        "Utility",
      ]
    ),
    .target(
      name: "Model",
      dependencies: [
        .product(name: "OrderedCollections", package: "swift-collections"),
        .product(name: "HandySwift", package: "HandySwift"),
        .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
      ],
      resources: [
        .process("Model.xcdatamodeld")
      ]
    ),
    .testTarget(
      name: "ModelTests",
      dependencies: ["Model"]
    ),
    .target(
      name: "TimerFeature",
      dependencies: [
        .product(name: "HandySwift", package: "HandySwift"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Model",
        "ReflectionFeature",
        "Resources",
        .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
        "Utility",
      ]
    ),
    .testTarget(
      name: "TimerFeatureTests",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "TimerFeature",
      ]
    ),
    .target(
      name: "ReflectionFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "HandySwift", package: "HandySwift"),
        "Model",
        "Resources",
        "Utility",
      ]
    ),
    .target(
      name: "Resources",
      resources: [
        .process("Localizable")
      ]
    ),
    .target(
      name: "Utility",
      dependencies: [
        .product(name: "CombineSchedulers", package: "combine-schedulers"),
        "Model",
      ]
    ),
  ]
)
