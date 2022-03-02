import ComposableArchitecture
import Model
import CoreData
import Utility

public let reflectionReducer = Reducer<ReflectionState, ReflectionAction, AppEnv> { state, action, env in
  switch action {
  case .binding(\.$progress):
    #warning("add support for multiple texts")
    var nextStepsTextEntry = state.focusTimer.typedProgressPoints.first

    if nextStepsTextEntry == nil {
      nextStepsTextEntry = RichTextEntry(
        context: env.managedObjectContext,
        text: state.nextSteps,
        focusTimer: state.focusTimer
      )
      #warning("performance: consider removing this to prevent unnecessary saves")
      try! env.managedObjectContext.save()
    }
    else {
      nextStepsTextEntry?.text = state.progress
    }

    state.focusTimer.typedProgressPoints = [nextStepsTextEntry!]
    try! env.managedObjectContext.save()

  case .binding(\.$learnings):
    #warning("add support for multiple texts")
    var nextStepsTextEntry = state.focusTimer.typedLearnings.first

    if nextStepsTextEntry == nil {
      nextStepsTextEntry = RichTextEntry(
        context: env.managedObjectContext,
        text: state.nextSteps,
        focusTimer: state.focusTimer
      )
    }
    else {
      nextStepsTextEntry?.text = state.learnings
    }

    state.focusTimer.typedLearnings = [nextStepsTextEntry!]
    try! env.managedObjectContext.save()

  case .binding(\.$problems):
    #warning("add support for multiple texts")
    var nextStepsTextEntry = state.focusTimer.typedProblems.first

    if nextStepsTextEntry == nil {
      nextStepsTextEntry = RichTextEntry(
        context: env.managedObjectContext,
        text: state.nextSteps,
        focusTimer: state.focusTimer
      )
    }
    else {
      nextStepsTextEntry?.text = state.problems
    }

    state.focusTimer.typedProblems = [nextStepsTextEntry!]
    try! env.managedObjectContext.save()

  case .binding(\.$nextSteps):
    #warning("add support for multiple texts")
    var nextStepsTextEntry = state.focusTimer.typedNextSteps.first

    if nextStepsTextEntry == nil {
      nextStepsTextEntry = RichTextEntry(
        context: env.managedObjectContext,
        text: state.nextSteps,
        focusTimer: state.focusTimer
      )
    }
    else {
      nextStepsTextEntry?.text = state.nextSteps
    }

    state.focusTimer.typedNextSteps = [nextStepsTextEntry!]
    try! env.managedObjectContext.save()

  case .binding:
    break
  }

  return .none
}
.binding()
