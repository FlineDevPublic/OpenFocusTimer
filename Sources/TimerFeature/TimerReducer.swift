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
    return .init(value: .stopTimerRequested)

  case .stopTimerRequested:
    state.timerIsRunning = false
    return .cancel(id: TimerId())

  case .timerTicked:
    guard state.timeLeft > 0 else {
      return .merge(
        .init(value: .stopTimerRequested),
        .init(value: .timeIsUp)
      )

    }
    state.timeLeft -= .seconds(1)

  case .timeIsUp:
    return .init(value: .setTimeIsUpAlert(isPresented: true))

  case let .setTimeIsUpAlert(isPresented):
    state.showTimeIsUpAlert = isPresented
    if !isPresented {
      return .init(value: .timerResetRequested)
    }

  case .timerResetRequested:
    state.timeLeft = TimerState.lastUsedTimeLeft
  }

  return .none
}
.debugActions()
