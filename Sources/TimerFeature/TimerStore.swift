import ComposableArchitecture
import HandySwift

public struct TimerState: Equatable {
  var timerIsRunning: Bool = false
  var timeLeft: TimeInterval = .minutes(25)

  public init(
    timerIsRunning: Bool = false,
    timeLeft: TimeInterval = .minutes(25)
  ) {
    self.timerIsRunning = timerIsRunning
    self.timeLeft = timeLeft
  }
}

public enum TimerAction {
  case startButtonPressed
  case stopButtonPressed
}
