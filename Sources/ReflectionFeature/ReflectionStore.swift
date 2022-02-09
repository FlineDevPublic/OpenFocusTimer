import Foundation
import ComposableArchitecture
import HandySwift
import Model
import Utility

public struct ReflectionState: Equatable {
  var progress: String
  var problems: String
  var learnings: String
  var nextSteps: String

  public init(
    progress: String,
    problems: String,
    learnings: String,
    nextSteps: String
  ) {
    self.progress = progress
    self.problems = problems
    self.learnings = learnings
    self.nextSteps = nextSteps
  }
}

#warning("provide a new actual 'stop' button for cancelling out early")
public enum ReflectionAction: Equatable {
  case setProgress(String)
  case setProblems(String)
  case setLearnings(String)
  case setNextSteps(String)
}

#if DEBUG
  extension ReflectionState {
    static var mocked: Self {
      .init(progress: "", problems: "", learnings: "", nextSteps: "")
    }
  }
#endif
