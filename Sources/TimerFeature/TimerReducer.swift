import ComposableArchitecture
import Model
import CoreData
import Utility

public let timerReducer = Reducer<TimerState, TimerAction, AppEnv> { state, action, env in
  struct TimerId: Hashable {}

  switch action {
  case .startButtonPressed:
    state.play()
    try! env.managedObjectContext.save()

    #warning("make the 1 'second' more readable (unit not clear)")
    return Effect.timer(id: TimerId(), every: 1, tolerance: .zero, on: env.mainQueue)
      .map { _ in TimerAction.timerTicked }

  case .pauseButtonPressed:
    return .init(value: .pauseTimerRequested)

  case .pauseTimerRequested:
    state.pause()
    try! env.managedObjectContext.save()
    return .cancel(id: TimerId())

  case .timerTicked:
    state.tick()
    try! env.managedObjectContext.save()

    if state.currentFocusTimer.completed {
      return .merge(
        .cancel(id: TimerId()),
        .init(value: .setTimeIsUpAlert(isPresented: true))
      )
    }

  case let .setTimeIsUpAlert(isPresented):
    state.showTimeIsUpAlert = isPresented
    if !isPresented {
      return .init(value: .timerResetRequested)
    }

  case .timerResetRequested:
    state.reset(env: env)
  }

  return .none
}
