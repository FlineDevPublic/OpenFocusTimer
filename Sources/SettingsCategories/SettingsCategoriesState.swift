import ComposableArchitecture
import CoreData
import Foundation
import HandySwift
import Model
import SettingsEditCategory

public struct SettingsCategoriesState: Equatable {
   var categoryGroups: [CategoryGroup]
   var categoriesByGroup: [CategoryGroup: [Model.Category]]

   var editCategoryState: SettingsEditCategoryState?

   @BindableState
   var selectedGroup: CategoryGroup

   @BindableState
   var showDeleteConfirmDialog = false
   var categoryAwaitingDeleteConfirmation: Model.Category?

   public init(
      context: NSManagedObjectContext
   ) {
      do {
         self.categoryGroups = try context.fetch(CategoryGroup.fetchRequest())
         self.categoriesByGroup = [:]
         for group in self.categoryGroups {
            self.categoriesByGroup[group] = group.typedCategories.sorted { left, right in
               left.name!.lowercased(with: .current) < right.name!.lowercased(with: .current)
            }
         }
      } catch {
         #warning("[Dev] when app is ready for analytics / crash reporting")
         fatalError("error occurred while readong category (groups): \(error.localizedDescription)")
      }

      #warning("[Dev] handle cases where no groups exist properly")
      self.selectedGroup = categoryGroups.first!
   }
}

#if DEBUG
   extension SettingsCategoriesState: Withable {}
#endif
