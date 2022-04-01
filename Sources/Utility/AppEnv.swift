import Foundation
import CoreData
import CombineSchedulers
import Model

public struct AppEnv {
  public let mainQueue: AnySchedulerOf<DispatchQueue>
  public let managedObjectContext: NSManagedObjectContext
  public let nowDateProducer: () -> Date

  public init(
    mainQueue: AnySchedulerOf<DispatchQueue>,
    managedObjectContext: NSManagedObjectContext,
    nowDateProducer: @escaping () -> Date
  ) {
    self.mainQueue = mainQueue
    self.managedObjectContext = managedObjectContext
    self.nowDateProducer = nowDateProducer
  }
}

#if DEBUG
  extension AppEnv {
    public static var mocked: AppEnv {
      .init(
        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
        managedObjectContext: PersistenceController.mocked.container.viewContext,
        nowDateProducer: { Date.now }
      )
    }
  }
#endif
