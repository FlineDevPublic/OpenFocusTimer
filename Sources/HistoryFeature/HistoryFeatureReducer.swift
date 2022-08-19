import ComposableArchitecture
import Foundation
import Utility

public let historyFeatureReducer = Reducer.combine(
   Reducer<HistoryFeatureState, HistoryFeatureAction, AppEnv> { state, action, env in
      let actionHandler = HistoryFeatureActionHandler(env: env)

      switch action {
      case .onAppear:
         return actionHandler.onAppear(state: &state)

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
