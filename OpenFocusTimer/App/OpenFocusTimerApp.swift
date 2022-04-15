import AppEntryPoint
import Model
import SwiftUI

@main
struct OpenFocusTimerApp: App {
   let persistenceController = PersistenceController.shared

   var body: some Scene {
      WindowGroup {
         #warning("refactor this to integrate TimerFeature directly, remove AppEntryPoint entirely")
         AppEntryPointView(
            store: .init(
               initialState: .init(),
               reducer: appEntryPointReducer,
               environment: .init(
                  appEnv: .init(
                     mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                     managedObjectContext: PersistenceController.shared.container.viewContext,
                     nowDateProducer: { Date.now }
                  ),
                  databaseSeeder: .shared
               )
            )
         )
         .frame(width: 400, height: 400)
         .environment(\.managedObjectContext, persistenceController.container.viewContext)
      }

      //    WindowGroup {
      #warning("CONTINUE HERE: show main feature & start implementing sidebar & tab bar based main screen")
      //    }
   }
}
