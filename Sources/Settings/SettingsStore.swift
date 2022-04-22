import ComposableArchitecture
import CoreData
import Foundation
import Resources
import SFSafeSymbols
import SettingsCategories

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
            return L10n.Settings.GeneralTab.title

         case .categories:
            return L10n.Settings.CategoriesTab.title
         }
      }
   }

   var settingsCategoriesState: SettingsCategoriesState

   @BindableState
   var selectedTab: Tab = .general

   public init(context: NSManagedObjectContext) {
      self.settingsCategoriesState = .init(context: context)
   }
}

#warning("provide a new actual 'stop' button for cancelling out early")
public enum SettingsAction: Equatable, BindableAction {
   case settingsCategories(action: SettingsCategoriesAction)

   case binding(BindingAction<SettingsState>)
}
