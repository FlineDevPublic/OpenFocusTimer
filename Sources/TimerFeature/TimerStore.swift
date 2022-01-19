import Foundation
import ComposableArchitecture
import HandySwift

public struct TimerState: Equatable {
  #warning("extract the time left default value out into constants & change to 25 min")
  /// The time left the user provided on using the timer the last time. Defaults to some sensible value.
  public static var lastUsedTimeLeft: TimeInterval = .seconds(5)

  var timerIsRunning: Bool
  var timeLeft: TimeInterval
  var showTimeIsUpAlert: Bool = false

  public init(
    timerIsRunning: Bool = false,
    timeLeft: TimeInterval = Self.lastUsedTimeLeft
  ) {
    self.timerIsRunning = timerIsRunning
    self.timeLeft = timeLeft

    Self.lastUsedTimeLeft = timeLeft
  }
}

public enum TimerAction: Equatable {
  case startButtonPressed
  case stopButtonPressed
  case stopTimerRequested
  case timerTicked
  case timeIsUp
  case setTimeIsUpAlert(isPresented: Bool)
  case timerResetRequested
}
