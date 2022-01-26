import ComposableArchitecture
import Model
import CoreData
import Utility

public let appEntryReducer = Reducer<AppEntryPointState, AppEntryPointAction, AppEnv> { state, action, env in
  struct TimerId: Hashable {}

  switch action {
  case .didAppear:
    #warning("not yet implemented, continue here by reading the current focus timer from database")
    break
  }

  return .none
}
.debugActions()
