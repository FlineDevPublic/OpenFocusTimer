// swift-tools-version:5.5
import PackageDescription

let package = Package(
   name: "OpenFocusTimer",
   defaultLocalization: "en",
   platforms: [.macOS(.v12), .iOS(.v15)],
   products: [
      .library(name: "CategoriesSelector", targets: ["CategoriesSelector"]),
      .library(name: "IOSEntryPoint", targets: ["IOSEntryPoint"]),
      .library(name: "MainFeature", targets: ["MainFeature"]),
      .library(name: "Model", targets: ["Model"]),
      .library(name: "TimerFeature", targets: ["TimerFeature"]),
      .library(name: "ReflectionFeature", targets: ["ReflectionFeature"]),
      .library(name: "Resources", targets: ["Resources"]),
      .library(name: "Settings", targets: ["Settings"]),
      .library(name: "SettingsCategories", targets: ["SettingsCategories"]),
      .library(name: "SettingsEditCategory", targets: ["SettingsEditCategory"]),
      .library(name: "Utility", targets: ["Utility"]),
   ],
   dependencies: [
      // Commonly used data structures for Swift
      .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),

      // Handy Swift features that didn't make it into the Swift standard library.
      .package(url: "https://github.com/Flinesoft/HandySwift", from: "3.4.0"),

      // Handy SwiftUI features that didn't make it into the SwiftUI (yet).
      .package(url: "https://github.com/Flinesoft/HandySwiftUI", .branch("main")),

      // ⏰ A few schedulers that make working with Combine more testable and more versatile.
      .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.5.3"),

      // A library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind.
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.33.1"),

      // Safely access Apple's SF Symbols using static typing Topics
      .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols", branch: "stable"),
   ],
   targets: [
      .target(
         name: "CategoriesSelector",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            "Model",
            "Resources",
            "Utility",
         ]
      ),
      .target(
         name: "IOSEntryPoint",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "HandySwift", package: "HandySwift"),
            .product(name: "HandySwiftUI", package: "HandySwiftUI"),
            "MainFeature",
            "Resources",
            "Settings",
            "TimerFeature",
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
            "Utility",
         ]
      ),
      .target(
         name: "MainFeature",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            "Utility",
         ]
      ),
      .target(
         name: "Model",
         dependencies: [
            .product(name: "OrderedCollections", package: "swift-collections"),
            .product(name: "HandySwift", package: "HandySwift"),
            "Resources",
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
         ],
         resources: [
            .process("Model.xcdatamodeld")
         ]
      ),
      .target(
         name: "TimerFeature",
         dependencies: [
            .product(name: "HandySwift", package: "HandySwift"),
            "CategoriesSelector",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            "Model",
            "ReflectionFeature",
            "Resources",
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
            "Utility",
         ]
      ),
      .target(
         name: "ReflectionFeature",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "HandySwift", package: "HandySwift"),
            .product(name: "HandySwiftUI", package: "HandySwiftUI"),
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
         name: "Settings",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            "Resources",
            "SettingsCategories",
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
            "Utility",
         ]
      ),
      .target(
         name: "SettingsCategories",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "HandySwift", package: "HandySwift"),
            .product(name: "HandySwiftUI", package: "HandySwiftUI"),
            "Model",
            "Resources",
            "SettingsEditCategory",
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
            "Utility",
         ]
      ),
      .target(
         name: "SettingsEditCategory",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "HandySwift", package: "HandySwift"),
            .product(name: "HandySwiftUI", package: "HandySwiftUI"),
            "Resources",
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
            "Utility",
         ]
      ),
      .target(
         name: "Utility",
         dependencies: [
            .product(name: "CombineSchedulers", package: "combine-schedulers"),
            "Model",
         ]
      ),
      .testTarget(
         name: "ModelTests",
         dependencies: ["Model"]
      ),
      .testTarget(
         name: "TimerFeatureTests",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            "TimerFeature",
         ]
      ),
   ]
)
