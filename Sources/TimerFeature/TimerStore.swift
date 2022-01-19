import ComposableArchitecture
import HandySwift

public struct TimerState: Equatable {
  var timerIsRunning: Bool
  var timeLeft: TimeInterval
  var showTimeIsUpAlert: Bool = false

  #warning("extract the time left default value out into constants & change to 25 min")
  public init(
    timerIsRunning: Bool = false,
    timeLeft: TimeInterval = .seconds(5)
  ) {
    self.timerIsRunning = timerIsRunning
    self.timeLeft = timeLeft
  }
}

public enum TimerAction: Equatable {
  case startButtonPressed
  case stopButtonPressed
  case stopTimerRequested
  case timerTicked
  case timeIsUp
  case setTimeIsUpAlert(isPresented: Bool)
}
