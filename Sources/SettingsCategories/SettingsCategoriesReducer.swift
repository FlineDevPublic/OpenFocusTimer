import ComposableArchitecture
import Foundation
import Utility

public let settingsCategoriesReducer = Reducer.combine(
   Reducer<SettingsCategoriesState, SettingsCategoriesAction, AppEnv> { state, action, env in
      let actionHandler = SettingsCategoriesActionHandler(env: env)

      switch action {
      // redirect Action cases here to `actionHandler`

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
