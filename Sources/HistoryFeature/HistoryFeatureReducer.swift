import ComposableArchitecture
import Foundation
import Utility

public let historyFeatureReducer = Reducer.combine(
   Reducer<HistoryFeatureState, HistoryFeatureAction, AppEnv> { state, action, env in
      let actionHandler = HistoryFeatureActionHandler(env: env)

      switch action {
      // redirect Action cases here to `actionHandler`

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
