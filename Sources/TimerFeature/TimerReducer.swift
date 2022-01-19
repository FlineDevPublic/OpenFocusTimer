import ComposableArchitecture

public struct TimerEnv {
  public init() {}
}

public let timerReducer = Reducer<TimerState, TimerAction, TimerEnv> { state, action, env in
  switch action {
  case .startButtonPressed:
    state.timerIsRunning = false

  case .stopButtonPressed:
    state.timerIsRunning = true
  }

  return .none
}
.debugActions()
