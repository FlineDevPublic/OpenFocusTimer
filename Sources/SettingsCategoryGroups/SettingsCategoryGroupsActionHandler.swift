import ComposableArchitecture
import Foundation
import Model
import Utility

struct SettingsCategoryGroupsActionHandler {
   typealias State = SettingsCategoryGroupsState
   typealias Action = SettingsCategoryGroupsAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func editCategoryGroupSaveButtonPressed(state: inout State) -> Next {
      self.reloadData(state: &state)
      return .init(value: .setEditCategoryGroup(isPresented: false))
   }

   func setEditCategoryGroup(state: inout State, isPresented: Bool) -> Next {
      state.editCategoryGroupState = isPresented ? .init(existingCategoryGroup: nil) : nil
      return .none
   }

   func editCategoryGroupButtonPressed(state: inout State, categoryGroup: Model.CategoryGroup) -> Next {
      state.editCategoryGroupState = .init(existingCategoryGroup: categoryGroup)
      return .none
   }

   func deleteCategoryGroupButtonPressed(state: inout State, categoryGroup: Model.CategoryGroup) -> Next {
      state.showDeleteConfirmDialog = true
      state.categoryGroupAwaitingDeleteConfirmation = categoryGroup
      return .none
   }

   func deleteCategoryGroupConfirmed(state: inout State) -> Next {
      guard let categoryGroupToDelete = state.categoryGroupAwaitingDeleteConfirmation else {
         assertionFailure("There should always be a category group awaiting delete confirmation when deletion is confirmed.")
         return .none
      }

      env.managedObjectContext.delete(categoryGroupToDelete)
      try! env.managedObjectContext.save()

      self.reloadData(state: &state)

      if state.editCategoryGroupState != nil {
         return .init(value: .setEditCategoryGroup(isPresented: false))
      } else {
         return .none
      }
   }

   private func reloadData(state: inout State) {
      do {
         state.categoryGroups = try env.managedObjectContext.fetch(CategoryGroup.fetchRequest())
      } catch {
         #warning("🧑‍💻 when app is ready for analytics / crash reporting")
         fatalError("error occurred while reading category groups: \(error.localizedDescription)")
      }
   }
}
