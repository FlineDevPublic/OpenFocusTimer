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

    case .categoriesSelector(action: .closeButtonPressed):
      return .init(value: .setCategoriesSelector(isPresented: false))

    case .reflection(action: .closeButtonPressed):
      return .init(value: .setReflection(isPresented: false))

    case .reflection, .categoriesSelector:
      break  // handled by the child reducer

    case .editSummaryButtonPressed:
      return .init(value: .setReflection(isPresented: true))

    case .editCategoriesButtonPressed:
      return .init(value: .setCategoriesSelector(isPresented: true))

    case let .setReflection(isPresented):
      state.reflectionState = isPresented ? .init(focusTimer: state.currentFocusTimer) : nil

    case let .setCategoriesSelector(isPresented):
      state.categoriesSelectorState = isPresented ? .init(focusTimer: state.currentFocusTimer, context: env.managedObjectContext) : nil
    }

    return .none
  }
)
