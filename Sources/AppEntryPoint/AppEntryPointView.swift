import SwiftUI
import CoreData
import Model
import TimerFeature
import ComposableArchitecture

public struct AppEntryPointView: View {
  let store: Store<AppEntryPointState, AppEntryPointAction>

  public init(
    store: Store<AppEntryPointState, AppEntryPointAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      NavigationView {
        VStack {
          #warning("preview navigation place, add to proper place later")
          NavigationLink("Show timer feature") {
            TimerView(
              store: .init(
                initialState: .init(currentFocusTimer: viewStore.currentFocusTimer),
                reducer: timerReducer,
                environment: .init(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                  managedObjectContext: PersistenceController.shared.container.viewContext,
                  nowDateProducer: { Date.now }
                )
              )
            )
          }
        }
      }
      .onAppear {
        viewStore.send(.didAppear)
      }
    }
  }
}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    private static let store = Store(
      initialState: .init(),
      reducer: appEntryReducer,
      environment: .mocked
    )

    static var previews: some View {
      AppEntryPointView(store: store)
    }
  }
#endif
