import ComposableArchitecture
import Foundation
import HandySwift
import Model
import Utility

public struct ReflectionState: Equatable {
   var focusTimer: FocusTimer

   @BindableState
   var progress: String

   @BindableState
   var problems: String

   @BindableState
   var learnings: String

   @BindableState
   var nextSteps: String

   public init(
      focusTimer: FocusTimer
   ) {
      self.focusTimer = focusTimer

      let separator = "\n"
      self.progress = focusTimer.typedProgressPoints.map(\.text!).joined(separator: separator)
      self.problems = focusTimer.typedProblems.map(\.text!).joined(separator: separator)
      self.learnings = focusTimer.typedLearnings.map(\.text!).joined(separator: separator)
      self.nextSteps = focusTimer.typedNextSteps.map(\.text!).joined(separator: separator)
   }
}

#warning("🧑‍💻 provide a new actual 'stop' button for cancelling out early")
public enum ReflectionAction: Equatable, BindableAction {
   case binding(BindingAction<ReflectionState>)
   case closeButtonPressed
}

#if DEBUG
   extension ReflectionState {
      static var mocked: Self {
         .init(focusTimer: .mocked)
      }
   }
#endif
