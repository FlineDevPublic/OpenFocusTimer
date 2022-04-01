import ComposableArchitecture
import Model
import CoreData
import Utility
import ReflectionFeature
import CategoriesSelector

public let timerReducer = Reducer.combine(
  categoriesSelectorReducer
    .optional()
    .pullback(
      state: \TimerState.categoriesSelectorState,
      action: /TimerAction.categoriesSelector(action:),
      environment: { $0 }
    ),
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
      #warning("put this into a modal")
      state.categoriesSelectorState = .init(focusTimer: state.currentFocusTimer, context: env.managedObjectContext)
      #warning("allow hiding away reflection state to save space while working – alternatively, implement a mini mode")
      state.reflectionState = .init(.init(focusTimer: state.currentFocusTimer))

    case .startOrContinueButtonPressed:
      state.play()
      try! env.managedObjectContext.save()

      return Effect.timer(id: TimerId(), every: .init(.seconds(1)), tolerance: .zero, on: env.mainQueue)
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

    case .reflection, .categoriesSelector:
      break  // handled by the child reducer
    }

    return .none
  }
)
