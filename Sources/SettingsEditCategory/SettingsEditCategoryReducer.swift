import ComposableArchitecture
import Foundation
import Utility

public let settingsEditCategoryReducer = Reducer.combine(
   Reducer<SettingsEditCategoryState, SettingsEditCategoryAction, AppEnv> { state, action, env in
      let actionHandler = SettingsEditCategoryActionHandler(env: env)

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
