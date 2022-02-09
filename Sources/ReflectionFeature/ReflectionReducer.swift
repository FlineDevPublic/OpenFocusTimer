import ComposableArchitecture
import Model
import CoreData
import Utility

public let reflectionReducer = Reducer<ReflectionState, ReflectionAction, AppEnv> { state, action, env in
  switch action {
  case let .setProgress(progress):
    state.progress = progress

    state.focusTimer.progressPoints = [state.progress]
    try! env.managedObjectContext.save()

  case let .setLearnings(learnings):
    state.learnings = learnings

    state.focusTimer.learnings = [state.learnings]
    try! env.managedObjectContext.save()

  case let .setProblems(problems):
    state.problems = problems

    state.focusTimer.problems = [state.problems]
    try! env.managedObjectContext.save()

  case let .setNextSteps(nextSteps):
    state.nextSteps = nextSteps

    state.focusTimer.nextSteps = [state.nextSteps]
    try! env.managedObjectContext.save()
  }

  return .none
}
