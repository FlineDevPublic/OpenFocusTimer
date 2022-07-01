import ComposableArchitecture
import Utility

public let mainFeatureReducer = Reducer<MainFeatureState, MainFeatureAction, AppEnv> { state, action, env in
   let actionHandler = MainFeatureActionHandler(env: env)

   switch action {
   case .sidebarEntryPressed(let sidebarEntry):
      return actionHandler.sidebarEntryPressed(state: &state, sidebarEntry: sidebarEntry)

   case .binding:
      return .none  // assignment handled by `.binding()` below
   }
}
.binding()
.debugActions()
