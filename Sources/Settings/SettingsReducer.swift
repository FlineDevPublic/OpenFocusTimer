import ComposableArchitecture
import SettingsCategories
import SettingsCategoryGroups
import Utility

public let settingsReducer = Reducer.combine(
   settingsCategoriesReducer
      .pullback(
         state: \.settingsCategoriesState,
         action: /SettingsAction.settingsCategories(action:),
         environment: { $0 }
      ),
   settingsCategoryGroupsReducer
      .pullback(
         state: \.settingsCategoryGroupsState,
         action: /SettingsAction.settingsCategoryGroups(action:),
         environment: { $0 }
      ),
   Reducer<SettingsState, SettingsAction, AppEnv> { state, action, env in
      let actionHandler = SettingsCategoriesActionHandler(env: env)

      switch action {
      case .settingsCategoryGroups(action: .categoryGroupsChanged):
         return actionHandler.categoryGroupsChanged(state: &state)

      case .settingsCategories, .settingsCategoryGroups:
         break  // handled by child reducer

      case .binding:
         break  // handled by the `.binding()` call below
      }
      return .none
   }
   .binding()
)
.debugActions()
