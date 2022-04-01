import Foundation
import ComposableArchitecture
import HandySwift
import Model
import Utility
import ReflectionFeature

public struct TimerState {
  var currentFocusTimer: FocusTimer
  var showTimeIsUpAlert: Bool = false

  var timerIsRunning: Bool
  var timeLeft: TimeInterval

  var reflectionState: ReflectionState?

  var categoryGroups: [CategoryGroup] = []
  var categoriesByGroup: [CategoryGroup: [Model.Category]] = [:]
  var selectedGroupCategories: [CategoryGroup: Model.Category] = [:]

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
    #warning("ask for categories & focus topic")
    self.updateLocalStateWithFocusTimer()

    if self.reflectionState != nil {
      self.reflectionState = .init(focusTimer: self.currentFocusTimer)
    }
  }

  func selectedCategory(group: CategoryGroup) -> Model.Category? {
    self.currentFocusTimer.typedCategories.first { $0.group == group }
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

#warning("provide a new actual 'stop' button for cancelling out early")
public enum TimerAction: Equatable {
  case didAppear

  case startOrContinueButtonPressed
  case pauseButtonPressed
  case pauseTimerRequested
  case timerTicked
  case setTimeIsUpAlert(isPresented: Bool)
  case timerResetRequested

  case reflection(action: ReflectionAction)
  case categoryGroupSelectionChanged(group: CategoryGroup, category: Model.Category)
}

extension TimerState: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.showTimeIsUpAlert == rhs.showTimeIsUpAlert
      && lhs.timerIsRunning == rhs.timerIsRunning
      && lhs.timeLeft == rhs.timeLeft
  }
}
