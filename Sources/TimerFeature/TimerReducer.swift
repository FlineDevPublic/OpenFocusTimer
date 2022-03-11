import ComposableArchitecture
import Model
import CoreData
import Utility
import ReflectionFeature

public let timerReducer = Reducer.combine(
  reflectionReducer
    .optional()
    .pullback(
      state: \TimerState.reflectionState,
      action: /TimerAction.reflection(action:),
      environment: { $0 }
    ),
  Reducer<TimerState, TimerAction, AppEnv> { state, action, env in
    struct TimerId: Hashable {}

    switch action {
    case .didAppear:
      #warning("showing reflection state at all times for debugging purposes")
      state.reflectionState = .init(.init(focusTimer: state.currentFocusTimer))

    case .startOrContinueButtonPressed:
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

    case .reflection:
      break  // handled by the child reducer
    }

    return .none
  }
)
