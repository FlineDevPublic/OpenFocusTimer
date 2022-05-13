import ComposableArchitecture
import Foundation
import MainFeature
import Model
import Settings
import TimerFeature
import Utility

public let iOSEntryPointReducer = Reducer.combine(
   timerReducer
      .pullback(
         state: \IOSEntryPointState.timerState,
         action: /IOSEntryPointAction.timer(action:),
         environment: { $0 }
      ),
   mainFeatureReducer
      .pullback(
         state: \IOSEntryPointState.mainFeatureState,
         action: /IOSEntryPointAction.mainFeature(action:),
         environment: { $0 }
      ),
   settingsReducer
      .pullback(
         state: \IOSEntryPointState.settingsState,
         action: /IOSEntryPointAction.settings(action:),
         environment: { $0 }
      ),
   Reducer<IOSEntryPointState, IOSEntryPointAction, AppEnv> { state, action, env in
      let actionHandler = IOSEntryPointActionHandler(env: env)

      switch action {
      case .timer, .mainFeature, .settings:
         return .none  // handled by child reducers

      case .binding:
         return .none  // assignment handled by `.binding()` below

      }
   }
   .binding()
)
