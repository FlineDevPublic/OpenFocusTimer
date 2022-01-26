import Foundation
import CoreData

extension CategoryGroup {
  public convenience init(
    context: NSManagedObjectContext,
    name: String
  ) {
    self.init(context: context)
    self.name = name
  }
}
