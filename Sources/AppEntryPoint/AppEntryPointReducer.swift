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
    reflectionReducer
      .optional()
      .pullback(
        state: \AppEntryPointState.reflectionState,
        action: /AppEntryPointAction.reflection(action:),
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
          #warning("not yet implemented")
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

        #warning("showing reflection state at all times for debugging purposes")
        state.reflectionState = .init(.init(progress: "", problems: "", learnings: "", nextSteps: ""))

      case .timer:
        break  // handled by the child reducer

      case .reflection:
        break  // handled by the child reducer
      }

      return .none
    }
  )
  .debugActions()
