import SwiftUI
import CoreData
import Model
import TimerFeature

public struct ContentView: View {
  public init() {}

  public var body: some View {
    NavigationView {
      VStack {
        #warning("preview navigation place, add to proper place later")
        NavigationLink("Show timer feature") {
          TimerView(
            store: .init(
              initialState: .init(),
              reducer: timerReducer,
              environment: .init(mainQueue: DispatchQueue.main.eraseToAnyScheduler())
            )
          )
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
