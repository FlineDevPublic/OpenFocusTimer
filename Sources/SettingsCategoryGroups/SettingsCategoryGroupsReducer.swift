import ComposableArchitecture
import Foundation
import Utility

public let settingsCategoryGroupsReducer = Reducer.combine(
   Reducer<SettingsCategoryGroupsState, SettingsCategoryGroupsAction, AppEnv> { state, action, env in
      let actionHandler = SettingsCategoryGroupsActionHandler(env: env)

      switch action {
      // redirect Action cases here to `actionHandler`

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
