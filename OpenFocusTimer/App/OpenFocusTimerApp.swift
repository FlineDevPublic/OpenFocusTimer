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
          reducer: appEntryReducer,
          environment: .init(
            mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
            managedObjectContext: PersistenceController.shared.container.viewContext,
            nowDateProducer: { Date.now }
          )
        )
      )
      .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
