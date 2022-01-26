import ComposableArchitecture
import Model
import CoreData
import Utility

public let timerReducer = Reducer<TimerState, TimerAction, AppEnv> { state, action, env in
  struct TimerId: Hashable {}

  switch action {
  case .startButtonPressed:
    state.timerIsRunning = true

    #warning("not yet implemented, make sure to use the currentFocusTimer from the state")
    let focusTimer = FocusTimer(
      context: env.managedObjectContext,
      startedAt: env.nowDateProducer(),
      categories: [],
      focusTopic: "Placeholder Topic",
      timerRunoutDuration: TimerState.lastUsedTimeLeft
    )
    try! env.managedObjectContext.save()

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
