import ComposableArchitecture
import SettingsCategories
import Utility

public let settingsReducer = Reducer.combine(
   settingsCategoriesReducer
      .pullback(
         state: \.settingsCategoriesState,
         action: /SettingsAction.settingsCategories(action:),
         environment: { $0 }
      ),
   Reducer<SettingsState, SettingsAction, AppEnv> { state, action, env in
      switch action {
      case .settingsCategories:
         break  // handled by child reducer

      case .binding:
         break  // handled by the `.binding()` call below
      }
      return .none
   }
   .binding()
)
