import CoreData

extension NSManagedObjectContext {
   #if DEBUG
      public static var mocked: NSManagedObjectContext {
         let context = PersistenceController.mocked.container.viewContext
         try! DatabaseSeeder.shared.seed(context: context)
         return context
      }
   #endif
}
