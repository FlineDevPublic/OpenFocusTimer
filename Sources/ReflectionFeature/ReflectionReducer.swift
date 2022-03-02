import ComposableArchitecture
import Model
import CoreData
import Utility

public let reflectionReducer = Reducer<ReflectionState, ReflectionAction, AppEnv> { state, action, env in
  switch action {
  case .binding(\.$progress):
    state.focusTimer.progressPoints = [state.progress]
    try! env.managedObjectContext.save()

  case .binding(\.$learnings):
    state.focusTimer.learnings = [state.$learnings]
    try! env.managedObjectContext.save()

  case .binding(\.$problems):
    state.focusTimer.problems = [state.$problems]
    try! env.managedObjectContext.save()

  case .binding(\.$nextSteps):
    state.focusTimer.nextSteps = [state.$nextSteps]
    try! env.managedObjectContext.save()

  case .binding:
    break
  }

  return .none
}
