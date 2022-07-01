import ComposableArchitecture
import Foundation
import Utility

struct MainFeatureActionHandler {
   typealias State = MainFeatureState
   typealias Action = MainFeatureAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func sidebarEntryPressed(state: inout State, sidebarEntry: State.SidebarEntry) -> Next {
      state.selectedSidebarEntry = sidebarEntry
      return .none
   }
}
