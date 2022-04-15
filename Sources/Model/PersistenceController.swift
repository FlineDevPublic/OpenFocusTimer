import CoreData

public struct PersistenceController {
   public static let shared = PersistenceController()

   #if DEBUG
      public static let mocked = PersistenceController(inMemory: true)
   #endif

   public let container: NSPersistentContainer

   init(
      inMemory: Bool = false
   ) {
      let modelUrl = Bundle.swiftUIPreviewsCompatibleModule.url(forResource: "Model", withExtension: "momd")!
      let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl)!
      container = NSPersistentContainer(name: "Model", managedObjectModel: managedObjectModel)

      if inMemory {
         container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
      }

      container.viewContext.automaticallyMergesChangesFromParent = true
      container.loadPersistentStores { storeDescription, error in
         if let error = error as NSError? {
            #warning("not yet implemented")
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      }
   }
}
