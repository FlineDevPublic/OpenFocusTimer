import ComposableArchitecture
import Foundation
import Utility

public let statisticsFeatureReducer = Reducer.combine(
   Reducer<StatisticsFeatureState, StatisticsFeatureAction, AppEnv> { state, action, env in
      let actionHandler = StatisticsFeatureActionHandler(env: env)

      switch action {
      // redirect Action cases here to `actionHandler`

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
