import AppEntryPoint
import MainFeature
import Model
import Settings
import SwiftUI
import Utility

@main
struct OpenFocusTimerApp: App {
   let persistenceController = PersistenceController.shared

   var body: some Scene {
      #warning("make sure either only one of each window type can be shown or provide independent states")
      #warning("consider that on iOS there might just be one window, change the naming here")

      WindowGroup("Main") {
         MainFeatureView(store: .init(initialState: .init(), reducer: mainFeatureReducer, environment: self.createAppEnv()))
      }

      WindowGroup("Timer") {
         #warning("refactor this to integrate TimerFeature directly, remove AppEntryPoint entirely")
         AppEntryPointView(
            store: .init(
               initialState: .init(),
               reducer: appEntryPointReducer,
               environment: .init(appEnv: self.createAppEnv(), databaseSeeder: .shared)
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
}
