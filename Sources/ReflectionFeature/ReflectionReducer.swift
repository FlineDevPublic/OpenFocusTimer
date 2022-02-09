import ComposableArchitecture
import Model
import CoreData
import Utility

public let reflectionReducer = Reducer<ReflectionState, ReflectionAction, AppEnv> { state, action, env in
  switch action {
  case let .setProgress(progress):
    state.progress = progress

  case let .setLearnings(learnings):
    state.learnings = learnings

  case let .setProblems(problems):
    state.problems = problems

  case let .setNextSteps(nextSteps):
    state.nextSteps = nextSteps
  }

  return .none
}
