import Foundation
import ComposableArchitecture
import HandySwift
import Model
import Utility

public struct ReflectionState: Equatable {
  let focusTimer: FocusTimer

  var progress: String
  var problems: String
  var learnings: String
  var nextSteps: String

  public init(
    focusTimer: FocusTimer
  ) {
    self.focusTimer = focusTimer

    #warning("make sure that the relationships of the `focusTimer` object are available")

    let separator = "\n"
    self.progress = focusTimer.typedProgressPoints.map(\.text!).joined(separator: separator)
    self.problems = focusTimer.typedProblems.map(\.text!).joined(separator: separator)
    self.learnings = focusTimer.typedLearnings.map(\.text!).joined(separator: separator)
    self.nextSteps = focusTimer.typedNextSteps.map(\.text!).joined(separator: separator)
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
      .init(focusTimer: .mocked)
    }
  }
#endif
