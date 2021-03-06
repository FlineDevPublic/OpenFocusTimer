import CategoriesSelector
import ComposableArchitecture
import Foundation
import HandySwift
import Model
import ReflectionFeature
import Utility

public struct TimerState: Equatable {
   var currentFocusTimer: FocusTimer
   var showTimeIsUpAlert = false

   var timerIsRunning: Bool
   var timeLeft: TimeInterval

   var categoriesSelectorState: CategoriesSelectorState?
   var reflectionState: ReflectionState?

   /// - Parameter currentFocusTimer: A not finished focus timer from a previous app session can be passed here. If `nil`, a new one is created.
   public init(
      currentFocusTimer: FocusTimer
   ) {
      self.currentFocusTimer = currentFocusTimer
      self.timerIsRunning = self.currentFocusTimer.running
      self.timeLeft = self.currentFocusTimer.timeLeft
   }

   mutating func reset(env: AppEnv) {
      #warning("🧑‍💻 replace categories and placeholder with user-entered data")
      self.currentFocusTimer = FocusTimer(
         context: env.managedObjectContext,
         startedAt: env.nowDateProducer(),
         categories: [],
         focusTopic: "Placeholder Topic",
         timerRunoutDuration: FocusTimer.defaultTimerRunoutDuration
      )
      #warning("🧑‍💻 ask for categories & focus topic")
      self.updateLocalStateWithFocusTimer()

      if self.reflectionState != nil {
         self.reflectionState = .init(focusTimer: self.currentFocusTimer)
      }
   }

   mutating func play() {
      self.currentFocusTimer.play()
      self.updateLocalStateWithFocusTimer()
   }

   mutating func pause() {
      self.currentFocusTimer.pause()
      self.updateLocalStateWithFocusTimer()
   }

   mutating func tick(now: Date) {
      self.currentFocusTimer.tick(now: now)
      self.updateLocalStateWithFocusTimer()
   }

   private mutating func updateLocalStateWithFocusTimer() {
      self.timerIsRunning = self.currentFocusTimer.running
      self.timeLeft = self.currentFocusTimer.timeLeft
   }
}

#warning("🧑‍💻 provide a new actual 'stop' button for cancelling out early")
public enum TimerAction: Equatable {
   case startOrContinueButtonPressed
   case pauseButtonPressed
   case pauseTimerRequested
   case timerTicked
   case setTimeIsUpAlert(isPresented: Bool)
   case timerResetRequested

   case categoriesSelector(action: CategoriesSelectorAction)
   case reflection(action: ReflectionAction)

   case editSummaryButtonPressed
   case editCategoriesButtonPressed

   case timerIsUpAlertDismissButtonPressed
   case timerIsUpAlertEditSummaryButtonPressed

   case setCategoriesSelector(isPresented: Bool)
   case setReflection(isPresented: Bool)
}
