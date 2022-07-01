import ComposableArchitecture
import CoreData
import Foundation
import Resources
import SFSafeSymbols
import SettingsCategories
import SettingsCategoryGroups

public struct SettingsState: Equatable {
   public enum Tab: String, Identifiable, CaseIterable {
      case general
      case categoryGroups
      case categories

      public var id: String { self.rawValue }

      var systemSymbol: SFSymbol {
         switch self {
         case .general:
            return .gear

         case .categoryGroups:
            return .rectangle3Group

         case .categories:
            return .rectangleGrid2x2
         }
      }

      var displayName: String {
         switch self {
         case .general:
            return Loc.Settings.GeneralTab.Title.string

         case .categoryGroups:
            return Loc.Settings.CategoryGroupsTab.Title.string

         case .categories:
            return Loc.Settings.CategoriesTab.Title.string
         }
      }
   }

   var settingsCategoriesState: SettingsCategoriesState
   var settingsCategoryGroupsState: SettingsCategoryGroupsState

   @BindableState
   var selectedTab: Tab = .general

   public init(context: NSManagedObjectContext) {
      self.settingsCategoriesState = .init(context: context)
      self.settingsCategoryGroupsState = .init(context: context)
   }
}
