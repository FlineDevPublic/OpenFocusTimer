import ComposableArchitecture
import Foundation
import Utility

struct SettingsCategoryGroupsActionHandler {
   typealias State = SettingsCategoryGroupsState
   typealias Action = SettingsCategoryGroupsAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   // add Action handlers here
}
