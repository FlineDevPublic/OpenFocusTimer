import AppEntryPoint
import ComposableArchitecture
import Foundation
import MainFeature
import Model
import Settings
import Utility

public let iOSEntryPointReducer = Reducer.combine(
   appEntryPointReducer
      .pullback(
         state: \IOSEntryPointState.appEntryPointState,
         action: /IOSEntryPointAction.appEntryPoint(action:),
         environment: { .init(appEnv: $0, databaseSeeder: DatabaseSeeder.shared) }
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
      case .appEntryPoint, .mainFeature, .settings:
         return .none  // handled by child reducers

      case .binding:
         return .none  // assignment handled by `.binding()` below

      }
   }
   .binding()
)
