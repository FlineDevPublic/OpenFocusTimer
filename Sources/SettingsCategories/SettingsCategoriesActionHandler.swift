import ComposableArchitecture
import Foundation
import Model
import Utility

struct SettingsCategoriesActionHandler {
   typealias State = SettingsCategoriesState
   typealias Action = SettingsCategoriesAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func createNewCategoryButtoPressed(state: inout State) -> Next {
      #warning("not yet implemented")
      return .none
   }

   func deleteCategoryButtonPressed(state: inout State, category: Model.Category) -> Next {
      #warning("not yet implemented")
      return .none
   }
}
