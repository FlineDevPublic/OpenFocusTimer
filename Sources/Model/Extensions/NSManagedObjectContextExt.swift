import CoreData

extension NSManagedObjectContext {
   #if DEBUG
      public static var mocked: NSManagedObjectContext {
         let context = PersistenceController.mocked.container.viewContext
         try! DatabaseSeeder.shared.seed(context: context)

         let categories = try! context.fetch(Category.fetchRequest())

         #warning("🧑‍💻 reconsider implementation logic for FocuTimer, because it's hard to create a mocked/testable state of a finished one")
         50.times {
            let focusTimer = FocusTimer(
               context: context,
               startedAt: Date.now.addingTimeInterval(-.hours(Double(Int(randomBelow: 100)!))),
               categories: [categories.randomElement()!],
               focusTopic: "Topic #\(Int(randomBelow: 10))",
               timerRunoutDuration: .minutes(25)
            )

            1_600.times {
               focusTimer.tick(now: Date.now)
            }
         }

         try! context.save()
         return context
      }
   #endif
}
