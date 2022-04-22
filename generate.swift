#!/opt/homebrew/bin/swift-sh

import Files  // @JohnSundell ~> 4.2
import Foundation
import HandySwift  // @FlineDev ~> 3.4
import ShellOut  // @JohnSundell ~> 2.3

// MARK: - Input Handling

let usageInstructons: String = """

   Run like this: ./generate.swift <kind> <name>
   Replace <kind> with one of: package
   Replace <name> with the name to use for your generated file(s).

   For example: ./generate.swift package Login
   """

guard CommandLine.arguments.count == 3 else {
   print("ERROR: Wrong number of arguments. Expected 2, got \(CommandLine.arguments.count - 1).")
   print(usageInstructons)
   exit(EXIT_FAILURE)
}

enum Kind: String, CaseIterable {
   case package
}

guard let kind = Kind(rawValue: CommandLine.arguments[1]) else {
   print("ERROR: Unknown kind '\(CommandLine.arguments[1])'. Use one of: \(Kind.allCases)")
   print(usageInstructons)
   exit(EXIT_FAILURE)
}

let name = CommandLine.arguments[2]

// MARK: - Defining File Contents

func actionFileContents(name: String) -> String {
   """
   import ComposableArchitecture
   import Foundation

   public enum \(name)Action: Equatable, BindableAction {
      // add Action cases here

      case binding(BindingAction<\(name)State>)
   }

   """
}

func actionHandlerFileContents(name: String) -> String {
   """
   import ComposableArchitecture
   import Foundation
   import Utility

   struct \(name)ActionHandler {
      typealias State = \(name)State
      typealias Action = \(name)Action
      typealias Next = Effect<Action, Never>

      let env: AppEnv

      // add Action handlers here
   }

   """
}

func errorFileContents(name: String) -> String {
   """
   import Foundation

   public enum \(name)Error: Error {
      // MARK: - Leaf
      // None

      // MARK: - Nested
      // None

      // MARK: - Unexpected
      case unexpectedError(errorDescription: String)
   }

   """
}

func reducerFileContents(name: String) -> String {
   """
   import ComposableArchitecture
   import Foundation
   import Utility

   public let \(name.firstLowercased)Reducer = Reducer.combine(
      Reducer<\(name)State, \(name)Action, AppEnv> { state, action, env in
         let actionHandler = \(name)ActionHandler(env: env)

         switch action {
         // redirect Action cases here to `actionHandler`

         case .binding:
            return .none  // assignment handled by `.binding()` below
         }
      }
      .binding()
   )

   """
}

func stateFileContents(name: String) -> String {
   """
   import ComposableArchitecture
   import Foundation
   import HandySwift

   public struct \(name)State: Equatable {
      // add State properties here

      public init() {}
   }

   #if DEBUG
      extension \(name)State: Withable {}
   #endif

   """
}

func viewFileContents(name: String) -> String {
   """
   import ComposableArchitecture
   import Resources
   import SFSafeSymbols
   import SwiftUI
   import Utility

   public struct \(name)View: View {
      public var body: some View {
         WithViewStore(self.store) { viewStore in
            VStack {
               Spacer()
               HStack {
                  Spacer()
                  Text("\(name)")
                  Spacer()
               }
               Spacer()
            }
            .padding()
         }
      }

      let store: Store<\(name)State, \(name)Action>

      public init(store: Store<\(name)State, \(name)Action>) {
         self.store = store
      }
   }

   #if DEBUG
      struct \(name)View_Previews: PreviewProvider {
         static let store = Store(
            initialState: .init(),
            reducer: \(name.firstLowercased)Reducer,
            environment: .mocked
         )

         static var previews: some View {
            \(name)View(store: self.store).previewVariants()
         }
      }
   #endif

   """
}

// MARK: - Generating Code Files

switch kind {
case .package:
   let sourcesFolder = try Folder(path: "Sources")
   guard !sourcesFolder.containsSubfolder(named: name) else {
      print("ERROR: There's already a folder named '\(name)' in Sources, please delete it first and retry.")
      exit(EXIT_FAILURE)
   }

   let folder = try sourcesFolder.createSubfolder(at: name)

   let actionFile = try folder.createFile(named: "\(name)Action.swift")
   try actionFile.write(actionFileContents(name: name))

   let actionHandlerFile = try folder.createFile(named: "\(name)ActionHandler.swift")
   try actionHandlerFile.write(actionHandlerFileContents(name: name))

   let errorFile = try folder.createFile(named: "\(name)Error.swift")
   try errorFile.write(errorFileContents(name: name))

   let reducerFile = try folder.createFile(named: "\(name)Reducer.swift")
   try reducerFile.write(reducerFileContents(name: name))

   let stateFile = try folder.createFile(named: "\(name)State.swift")
   try stateFile.write(stateFileContents(name: name))

   let viewFile = try folder.createFile(named: "\(name)View.swift")
   try viewFile.write(viewFileContents(name: name))

   print(
      """
      Successfully generated files. To make all work, copy the following snippets to their respective places:

      ========================================================
      ===== Package.swift: Insert into `products:` array =====
      ========================================================

      .library(name: "\(name)", targets: ["\(name)"]),


      ========================================================
      ===== Package.swift: Insert into `targets:` array ======
      ========================================================

      .target(
         name: "\(name)",
         dependencies: [
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "HandySwift", package: "HandySwift"),
            "Resources",
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
            "Utility",
         ]
      ),

      ========================================================
      """
   )
}
