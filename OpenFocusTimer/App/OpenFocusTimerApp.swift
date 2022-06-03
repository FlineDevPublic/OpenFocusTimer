import MainFeature
import Model
import Settings
import SwiftUI
import TimerFeature
import Utility

#if !os(macOS)
   import IOSEntryPoint
#endif

@main
struct OpenFocusTimerApp: App {
   let persistenceController = PersistenceController.shared

   var body: some Scene {
      #warning("🧑‍💻 make sure either only one of each window type can be shown or provide independent states")
      #warning("🧑‍💻 consider that on iOS there might just be one window, change the naming here")

      #if os(macOS)
         WindowGroup("Main") {
            MainFeatureView(store: .init(initialState: .init(), reducer: mainFeatureReducer, environment: self.createAppEnv()))
         }

         WindowGroup("Timer") {
            TimerView(
               store: .init(
                  initialState: .init(currentFocusTimer: self.currentFocusTimer()),
                  reducer: timerReducer,
                  environment: self.createAppEnv()
               )
            )
            .frame(width: 400, height: 400)
            .environment(\.managedObjectContext, self.persistenceController.container.viewContext)
         }

         Settings {
            SettingsView(
               store: .init(
                  initialState: .init(context: self.persistenceController.container.viewContext),
                  reducer: settingsReducer,
                  environment: self.createAppEnv()
               )
            )
         }
      #else
         WindowGroup {
            IOSEntryPointView(
               store: .init(
                  initialState: .init(context: self.persistenceController.container.viewContext, currentFocusTimer: self.currentFocusTimer()),
                  reducer: iOSEntryPointReducer,
                  environment: self.createAppEnv()
               )
            )
         }
      #endif
   }

   init() {
      try! DatabaseSeeder.shared.seed(context: self.persistenceController.container.viewContext)
   }

   private func createAppEnv() -> AppEnv {
      .init(
         mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
         managedObjectContext: PersistenceController.shared.container.viewContext,
         nowDateProducer: { Date.now }
      )
   }

   private func currentFocusTimer() -> FocusTimer {
      let fetchRequest = FocusTimer.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "endedAt == nil")
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startedAt", ascending: false)]

      var currentFocusTimer: FocusTimer?

      let env = self.createAppEnv()
      do {
         let runningfocusTimers = try env.managedObjectContext.fetch(fetchRequest)
         currentFocusTimer = runningfocusTimers.first
      } catch {
         #warning("🧑‍💻 when app is ready for analytics / crash reporting")
         fatalError("error occurred while reading category (groups): \(error.localizedDescription)")
      }

      if let currentFocusTimer = currentFocusTimer {
         return currentFocusTimer
      } else {
         return FocusTimer(
            context: env.managedObjectContext,
            startedAt: env.nowDateProducer(),
            categories: [],
            focusTopic: "Placeholder Topic",
            timerRunoutDuration: FocusTimer.defaultTimerRunoutDuration
         )
         #warning("🧑‍💻 ask for categories & focus topic")
      }
   }
}
