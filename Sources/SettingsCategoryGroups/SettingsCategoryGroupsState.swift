import ComposableArchitecture
import CoreData
import Foundation
import HandySwift
import Model
import SettingsEditCategoryGroup

public struct SettingsCategoryGroupsState: Equatable {
   var categoryGroups: [CategoryGroup]

   var editCategoryGroupState: SettingsEditCategoryGroupState?

   @BindableState
   var showDeleteConfirmDialog = false
   var categoryGroupAwaitingDeleteConfirmation: Model.CategoryGroup?

   public init(
      context: NSManagedObjectContext
   ) {
      do {
         self.categoryGroups = try context.fetch(CategoryGroup.fetchRequest())
      } catch {
         #warning("🧑‍💻 when app is ready for analytics / crash reporting")
         fatalError("error occurred while reading category (groups): \(error.localizedDescription)")
      }
   }
}

#if DEBUG
   extension SettingsCategoryGroupsState: Withable {}
#endif
