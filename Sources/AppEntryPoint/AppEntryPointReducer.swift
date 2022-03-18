import ComposableArchitecture
import Model
import CoreData
import Utility
import TimerFeature
import ReflectionFeature

public let appEntryPointReducer =
  Reducer.combine(
    timerReducer
      .optional()
      .pullback(
        state: \AppEntryPointState.timerState,
        action: /AppEntryPointAction.timer(action:),
        environment: { $0 }
      ),
    Reducer<AppEntryPointState, AppEntryPointAction, AppEnv> { state, action, env in
      struct TimerId: Hashable {}

      switch action {
      case .didAppear:
        let fetchRequest = FocusTimer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "endedAt == nil")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startedAt", ascending: false)]

        var currentFocusTimer: FocusTimer?

        do {
          let runningfocusTimers = try env.managedObjectContext.fetch(fetchRequest)
          currentFocusTimer = runningfocusTimers.first
        }
        catch {
          #warning("when app is ready for analytics / crash reporting")
          fatalError("handle error later")
        }

        if currentFocusTimer == nil {
          currentFocusTimer = FocusTimer(
            context: env.managedObjectContext,
            startedAt: env.nowDateProducer(),
            categories: [],
            focusTopic: "Placeholder Topic",
            timerRunoutDuration: FocusTimer.defaultTimerRunoutDuration
          )
          #warning("ask for categories & focus topic")
        }
        state.timerState = .init(currentFocusTimer: currentFocusTimer!)

      case .timer:
        break  // handled by the child reducer
      }

      return .none
    }
  )
  .debugActions()
