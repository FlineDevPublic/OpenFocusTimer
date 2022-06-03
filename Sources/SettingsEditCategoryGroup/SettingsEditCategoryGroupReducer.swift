import ComposableArchitecture
import Foundation
import Utility

public let settingsEditCategoryGroupReducer = Reducer.combine(
   Reducer<SettingsEditCategoryGroupState, SettingsEditCategoryGroupAction, AppEnv> { state, action, env in
      let actionHandler = SettingsEditCategoryGroupActionHandler(env: env)

      switch action {
      case .saveButtonPressed:
         return actionHandler.saveButtonPressed(state: &state)

      case .cancelButtonPressed, .deleteConfirmed:
         return .none  // handled by parent reducer

      case .deleteButtonPressed:
         return actionHandler.deleteButtonPressed(state: &state)

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
