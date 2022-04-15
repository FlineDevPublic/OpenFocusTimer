import ComposableArchitecture
import Foundation
import SFSafeSymbols

public struct SettingsState: Equatable {
   public enum Tab: String, Identifiable, CaseIterable {
      case general
      case categories

      public var id: String { self.rawValue }

      var systemSymbol: SFSymbol {
         switch self {
         case .general:
            return .gear

         case .categories:
            return .rectangleGrid2x2
         }
      }

      var displayName: String {
         switch self {
         case .general:
            return "General"

         case .categories:
            return "Categories"
         }
      }
   }

   @BindableState
   var selectedTab: Tab = .general

   public init() {}
}

#warning("provide a new actual 'stop' button for cancelling out early")
public enum SettingsAction: Equatable, BindableAction {
   case binding(BindingAction<SettingsState>)
}
