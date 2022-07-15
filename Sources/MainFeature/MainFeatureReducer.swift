import ComposableArchitecture
import HistoryFeature
import StatisticsFeature
import Utility

public let mainFeatureReducer = Reducer.combine(
   historyFeatureReducer
      .pullback(
         state: \MainFeatureState.historyFeatureState,
         action: /MainFeatureAction.historyFeature,
         environment: { $0 }
      ),
   statisticsFeatureReducer
      .pullback(
         state: \MainFeatureState.statisticsFeatureState,
         action: /MainFeatureAction.statisticsFeature,
         environment: { $0 }
      ),
   Reducer<MainFeatureState, MainFeatureAction, AppEnv> { state, action, env in
      let actionHandler = MainFeatureActionHandler(env: env)

      switch action {
      case .sidebarEntryPressed(let sidebarEntry):
         return actionHandler.sidebarEntryPressed(state: &state, sidebarEntry: sidebarEntry)

      case .historyFeature, .statisticsFeature:
         return .none  // handled by child reducers

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
.debugActions()
