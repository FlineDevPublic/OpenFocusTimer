import CoreData
import Foundation

extension CategoryGroup {
   public convenience init(
      context: NSManagedObjectContext,
      name: String
   ) {
      self.init(context: context)
      self.name = name
   }

   public var typedCategories: Set<Category> {
      get {
         self.categories as! Set<Category>? ?? []
      }

      set {
         self.categories = NSSet(set: newValue)
      }
   }
}

#warning("make sure to use a proper identifier, e.g. the name could be made unique")
extension CategoryGroup: Identifiable {
   public var id: String {
      self.name!
   }
}
