import ComposableArchitecture
import CoreData
import Foundation
import HandySwift
import Model
import SettingsEditCategory

public struct SettingsCategoriesState: Equatable {
   var categoryGroups: [CategoryGroup] = []
   var categoriesByGroup: [CategoryGroup: [Model.Category]] = [:]

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
         self.categoryGroups = try Self.fetchCategoryGroups(context: context)
         self.categoriesByGroup = Self.fetchCategoriesByGroup(context: context, categoryGroups: self.categoryGroups)
      } catch {
         #warning("🧑‍💻 when app is ready for analytics / crash reporting")
         fatalError("error occurred while reading category (groups): \(error.localizedDescription)")
      }

      #warning("🧑‍💻 handle cases where no groups exist properly")
      self.selectedGroup = self.categoryGroups.first!
   }

   private static func fetchCategoryGroups(context: NSManagedObjectContext) throws -> [CategoryGroup] {
      try context.fetch(CategoryGroup.fetchRequest())
   }

   private static func fetchCategoriesByGroup(
      context: NSManagedObjectContext,
      categoryGroups: [CategoryGroup]
   ) -> [CategoryGroup: [Model.Category]] {
      var categoriesByGroup: [CategoryGroup: [Model.Category]] = [:]
      for group in categoryGroups {
         categoriesByGroup[group] = group.typedCategories.sorted { left, right in
            left.name!.lowercased(with: .current) < right.name!.lowercased(with: .current)
         }
      }
      return categoriesByGroup
   }

   public mutating func reloadData(context: NSManagedObjectContext) {
      do {
         self.categoryGroups = try Self.fetchCategoryGroups(context: context)
         self.categoriesByGroup = Self.fetchCategoriesByGroup(context: context, categoryGroups: self.categoryGroups)
      } catch {
         #warning("🧑‍💻 when app is ready for analytics / crash reporting")
         fatalError("error occurred while reading category (groups): \(error.localizedDescription)")
      }

      if !self.categoryGroups.contains(self.selectedGroup) {
         #warning("🧑‍💻 handle cases where no groups exist properly")
         self.selectedGroup = self.categoryGroups.first!
      }
   }
}

#if DEBUG
   extension SettingsCategoriesState: Withable {}
#endif
