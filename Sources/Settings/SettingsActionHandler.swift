import ComposableArchitecture
import Foundation
import Model
import Utility

struct SettingsCategoriesActionHandler {
   typealias State = SettingsState
   typealias Action = SettingsAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func categoryGroupsChanged(state: inout State) -> Next {
      state.settingsCategoriesState.reloadData(context: env.managedObjectContext)
      return .none
   }
}
