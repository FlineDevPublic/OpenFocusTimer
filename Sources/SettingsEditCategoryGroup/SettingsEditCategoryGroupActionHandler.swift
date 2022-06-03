import ComposableArchitecture
import Foundation
import Model
import Utility

struct SettingsEditCategoryGroupActionHandler {
   typealias State = SettingsEditCategoryGroupState
   typealias Action = SettingsEditCategoryGroupAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func saveButtonPressed(state: inout State) -> Next {
      if let existingCategoryGroup = state.existingCategoryGroup {
         existingCategoryGroup.name = state.name
      } else {
         _ = Model.CategoryGroup(context: env.managedObjectContext, name: state.name)
      }

      try! env.managedObjectContext.save()

      return .none
   }

   func deleteButtonPressed(state: inout State) -> Next {
      state.showDeleteConfirmDialog = true
      return .none
   }
}
