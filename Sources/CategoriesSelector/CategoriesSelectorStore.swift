import ComposableArchitecture
import CoreData
import Foundation
import Model
import Utility

public struct CategoriesSelectorState: Equatable {
   var focusTimer: FocusTimer

   var categoryGroups: [CategoryGroup]
   var categoriesByGroup: [CategoryGroup: [Model.Category]]

   var selectedGroupCategories: [CategoryGroup: Model.Category]

   public init(
      focusTimer: FocusTimer,
      context: NSManagedObjectContext
   ) {
      self.focusTimer = focusTimer

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

      self.selectedGroupCategories = [:]
      for category in focusTimer.typedCategories {
         self.selectedGroupCategories[category.group!] = category
      }
   }
}

public enum CategoriesSelectorAction: Equatable {
   case categoryGroupSelectionChanged(group: CategoryGroup, category: Model.Category?)
   case closeButtonPressed
}

#if DEBUG
   extension CategoriesSelectorState {
      static var mocked: Self {
         .init(focusTimer: .mocked, context: .mocked)
      }
   }
#endif
