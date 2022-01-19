import SwiftUI
import CoreData
import Model
import TimerFeature

public struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default
  )
  private var items: FetchedResults<Item>

  public init() {}

  public var body: some View {
    NavigationView {
      VStack {
        List {
          ForEach(items) { item in
            NavigationLink {
              Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            } label: {
              Text(item.timestamp!, formatter: itemFormatter)
            }
          }
          .onDelete(perform: deleteItems)
        }
        .toolbar {
          #if os(iOS)
            ToolbarItem(placement: .navigationBarTrailing) {
              EditButton()
            }
          #endif
          ToolbarItem {
            Button(action: addItem) {
              Label("Add Item", systemImage: "plus")
            }
          }
        }
        Text("Select an item")

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

  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()

      do {
        try viewContext.save()
      }
      catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)

      do {
        try viewContext.save()
      }
      catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
