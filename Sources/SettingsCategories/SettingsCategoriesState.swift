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

   public init(
      context: NSManagedObjectContext
   ) {
      do {
         self.categoryGroups = try context.fetch(CategoryGroup.fetchRequest())
         self.categoriesByGroup = [:]
         for group in self.categoryGroups {
            self.categoriesByGroup[group] = group.typedCategories.sorted { lhs, rhs in
               lhs.name!.lowercased(with: .current) < rhs.name!.lowercased(with: .current)
            }
         }
      } catch {
         #warning("when app is ready for analytics / crash reporting")
         fatalError("error occurred while readong category (groups): \(error.localizedDescription)")
      }

      #warning("handle cases where no groups exist properly")
      self.selectedGroup = categoryGroups.first!
   }
}

#if DEBUG
   extension SettingsCategoriesState: Withable {}
#endif
