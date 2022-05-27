import ComposableArchitecture
import Foundation
import Model
import Utility

struct SettingsEditCategoryActionHandler {
   typealias State = SettingsEditCategoryState
   typealias Action = SettingsEditCategoryAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func saveButtonPressed(state: inout State) -> Next {
      if let existingCategory = state.existingCategory {
         existingCategory.name = state.name
         existingCategory.colorHexCode = state.color.hexString
         existingCategory.iconSymbolName = state.icon.rawValue
      } else {
         _ = Model.Category(
            context: env.managedObjectContext,
            name: state.name,
            color: state.color,
            icon: state.icon,
            group: state.group
         )
      }

      try! env.managedObjectContext.save()

      return .none
   }

   func deleteButtonPressed(state: inout State) -> Next {
      state.showDeleteConfirmDialog = true
      return .none
   }
}
