import ComposableArchitecture
import Foundation
import Model
import Utility

struct SettingsCategoriesActionHandler {
   typealias State = SettingsCategoriesState
   typealias Action = SettingsCategoriesAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func editCategorySaveButtonPressed(state: inout State) -> Next {
      self.reloadData(state: &state)
      return .init(value: .setEditCategory(isPresented: false))
   }

   func setEditCategory(state: inout State, isPresented: Bool) -> Next {
      state.editCategoryState = isPresented ? .init(group: state.selectedGroup, existingCategory: nil) : nil
      return .none
   }

   func editCategoryButtonPressed(state: inout State, category: Model.Category) -> Next {
      state.editCategoryState = .init(group: state.selectedGroup, existingCategory: category)
      return .none
   }

   func deleteCategoryButtonPressed(state: inout State, category: Model.Category) -> Next {
      state.showDeleteConfirmDialog = true
      state.categoryAwaitingDeleteConfirmation = category
      return .none
   }

   func deleteCategoryConfirmed(state: inout State) -> Next {
      guard let categoryToDelete = state.categoryAwaitingDeleteConfirmation else {
         assertionFailure("There should always be a category awaiting delete confirmation when deletion is confirmed.")
         return .none
      }

      env.managedObjectContext.delete(categoryToDelete)
      try! env.managedObjectContext.save()

      self.reloadData(state: &state)
      return .none
   }

   private func reloadData(state: inout State) {
      do {
         state.categoryGroups = try env.managedObjectContext.fetch(CategoryGroup.fetchRequest())
         state.categoriesByGroup = [:]
         for group in state.categoryGroups {
            state.categoriesByGroup[group] = group.typedCategories.sorted { lhs, rhs in
               lhs.name!.lowercased(with: .current) < rhs.name!.lowercased(with: .current)
            }
         }
      } catch {
         #warning("when app is ready for analytics / crash reporting")
         fatalError("error occurred while readong category (groups): \(error.localizedDescription)")
      }
   }
}
