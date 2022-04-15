import ComposableArchitecture
import Utility

public let settingsReducer = Reducer<SettingsState, SettingsAction, AppEnv> { state, action, env in
   switch action {
   case .binding:
      break  // handled by the `.binding()` call below
   }
   return .none
}
.binding()
