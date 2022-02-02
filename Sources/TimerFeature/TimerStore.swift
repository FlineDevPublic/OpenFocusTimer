import Foundation
import ComposableArchitecture
import HandySwift
import Model
import Utility

public struct TimerState: Equatable {
  var currentFocusTimer: FocusTimer
  var showTimeIsUpAlert: Bool = false

  var timerIsRunning: Bool
  var timeLeft: TimeInterval

  /// - Parameter currentFocusTimer: A not finished focus timer from a previous app session can be passed here. If `nil`, a new one is created.
  public init(
    currentFocusTimer: FocusTimer
  ) {
    self.currentFocusTimer = currentFocusTimer
    self.timerIsRunning = self.currentFocusTimer.running
    self.timeLeft = self.currentFocusTimer.timeLeft
  }

  mutating func reset(env: AppEnv) {
    #warning("replace categories and placeholder with user-entered data")
    self.currentFocusTimer = FocusTimer(
      context: env.managedObjectContext,
      startedAt: env.nowDateProducer(),
      categories: [],
      focusTopic: "Placeholder Topic",
      timerRunoutDuration: FocusTimer.defaultTimerRunoutDuration
    )
    #warning("use the users last used runout duration instead of the default, ask for categories & focus topic")
    self.updateLocalStateWithFocusTimer()
  }

  mutating func play() {
    self.currentFocusTimer.play()
    self.updateLocalStateWithFocusTimer()
  }

  mutating func pause() {
    self.currentFocusTimer.pause()
    self.updateLocalStateWithFocusTimer()
  }

  mutating func tick(now: Date = .now) {
    self.currentFocusTimer.tick()
    self.updateLocalStateWithFocusTimer()
  }

  mutating func complete(now: Date = .now) {
    self.currentFocusTimer.complete()
    self.updateLocalStateWithFocusTimer()
  }

  private mutating func updateLocalStateWithFocusTimer() {
    self.timerIsRunning = self.currentFocusTimer.running
    self.timeLeft = self.currentFocusTimer.timeLeft
  }
}

#warning("rename 'stop' to 'pause' and provide a new actual 'stop' button for cancelling out early")
public enum TimerAction: Equatable {
  case startButtonPressed
  case pauseButtonPressed
  case pauseTimerRequested
  case timerTicked
  case setTimeIsUpAlert(isPresented: Bool)
  case timerResetRequested
}
