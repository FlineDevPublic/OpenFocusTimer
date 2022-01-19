import ComposableArchitecture

public struct TimerEnv {
  var mainQueue: AnySchedulerOf<DispatchQueue>

  public init(
    mainQueue: AnySchedulerOf<DispatchQueue>
  ) {
    self.mainQueue = mainQueue
  }
}

public let timerReducer = Reducer<TimerState, TimerAction, TimerEnv> { state, action, env in
  struct TimerId: Hashable {}

  switch action {
  case .startButtonPressed:
    state.timerIsRunning = true
    #warning("make the 1 'second' more readable (unit not clear)")
    return Effect.timer(id: TimerId(), every: 1, tolerance: .zero, on: env.mainQueue)
      .map { _ in TimerAction.timerTicked }

  case .stopButtonPressed:
    state.timerIsRunning = false
    return .cancel(id: TimerId())

  case .timerTicked:
    state.timeLeft -= .seconds(1)
  }

  return .none
}
.debugActions()
