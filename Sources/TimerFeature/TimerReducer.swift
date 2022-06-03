import CategoriesSelector
import ComposableArchitecture
import CoreData
import Model
import ReflectionFeature
import Utility

#warning("🧑‍💻 extract longer case handlers into a struct like described here: https://github.com/pointfreeco/swift-composable-architecture/discussions/1052#discussioncomment-2527068")

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

         if state.currentFocusTimer.hasNotStarted {
            return Effect.merge(
               Effect.timer(id: TimerId(), every: .init(.seconds(1)), tolerance: .zero, on: env.mainQueue)
                  .map { _ in TimerAction.timerTicked },
               .init(value: .setCategoriesSelector(isPresented: true))
            )
         } else {
            return Effect.timer(id: TimerId(), every: .init(.seconds(1)), tolerance: .zero, on: env.mainQueue)
               .map { _ in TimerAction.timerTicked }
         }

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

      case .setTimeIsUpAlert(let isPresented):
         state.showTimeIsUpAlert = isPresented

      case .timerResetRequested:
         state.reset(env: env)

      case .categoriesSelector(action: .closeButtonPressed):
         return .init(value: .setCategoriesSelector(isPresented: false))

      case .reflection(action: .closeButtonPressed):
         if state.currentFocusTimer.completed {
            return .merge(
               .init(value: .timerResetRequested),
               .init(value: .setReflection(isPresented: false))
            )
         } else {
            return .init(value: .setReflection(isPresented: false))
         }

      case .reflection, .categoriesSelector:
         break  // handled by the child reducer

      case .editSummaryButtonPressed:
         return .init(value: .setReflection(isPresented: true))

      case .editCategoriesButtonPressed:
         return .init(value: .setCategoriesSelector(isPresented: true))

      case .timerIsUpAlertEditSummaryButtonPressed:
         return .init(value: .setReflection(isPresented: true))

      case .timerIsUpAlertDismissButtonPressed:
         return .init(value: .timerResetRequested)

      case .setReflection(let isPresented):
         state.reflectionState = isPresented ? .init(focusTimer: state.currentFocusTimer) : nil

      case .setCategoriesSelector(let isPresented):
         state.categoriesSelectorState = isPresented ? .init(focusTimer: state.currentFocusTimer, context: env.managedObjectContext) : nil
      }

      return .none
   }
)
