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
      _ = Model.Category(
         context: env.managedObjectContext,
         name: state.name,
         color: state.color,
         icon: state.icon,
         group: state.group
      )
      try! env.managedObjectContext.save()

      return .none
   }
}
