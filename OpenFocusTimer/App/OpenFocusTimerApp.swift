import SwiftUI
import AppEntryPoint
import Model

@main
struct OpenFocusTimerApp: App {
  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
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
      .frame(width: 800, height: 800)
      .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
