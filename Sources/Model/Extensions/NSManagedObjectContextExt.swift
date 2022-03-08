import CoreData

extension NSManagedObjectContext {
  #if DEBUG
    static var mocked: NSManagedObjectContext {
      PersistenceController.mocked.container.viewContext
    }
  #endif
}
