import ComposableArchitecture
import Model
import CoreData
import Utility
import TimerFeature
import ReflectionFeature

public struct AppEntryPointEnv {
  let appEnv: AppEnv
  let databaseSeeder: DatabaseSeeder

  public init(
    appEnv: AppEnv,
    databaseSeeder: DatabaseSeeder
  ) {
    self.appEnv = appEnv
    self.databaseSeeder = databaseSeeder
  }
}

#if DEBUG
  extension AppEntryPointEnv {
    public static var mocked: AppEntryPointEnv {
      .init(appEnv: .mocked, databaseSeeder: .shared)
    }
  }
#endif

public let appEntryPointReducer =
  Reducer.combine(
    timerReducer
      .optional()
      .pullback(
        state: \AppEntryPointState.timerState,
        action: /AppEntryPointAction.timer(action:),
        environment: { $0.appEnv }
      ),
    Reducer<AppEntryPointState, AppEntryPointAction, AppEntryPointEnv> { state, action, env in
      struct TimerId: Hashable {}

      switch action {
      case .didAppear:
        try! env.databaseSeeder.seed(context: env.appEnv.managedObjectContext)

        let fetchRequest = FocusTimer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "endedAt == nil")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startedAt", ascending: false)]

        var currentFocusTimer: FocusTimer?

        do {
          let runningfocusTimers = try env.appEnv.managedObjectContext.fetch(fetchRequest)
          currentFocusTimer = runningfocusTimers.first
        }
        catch {
          #warning("when app is ready for analytics / crash reporting")
          fatalError("error occurred while readong category (groups): \(error.localizedDescription)")
        }

        if currentFocusTimer == nil {
          currentFocusTimer = FocusTimer(
            context: env.appEnv.managedObjectContext,
            startedAt: env.appEnv.nowDateProducer(),
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
