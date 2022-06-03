import CoreData
import Foundation

extension CategoryGroup {
   public var typedCategories: Set<Category> {
      get {
         self.categories as! Set<Category>? ?? []
      }

      set {
         self.categories = NSSet(set: newValue)
      }
   }

   public convenience init(
      context: NSManagedObjectContext,
      name: String
   ) {
      self.init(context: context)
      self.name = name
   }
}

#warning("🧑‍💻 make sure to use a proper identifier, e.g. the name could be made unique")
extension CategoryGroup: Identifiable {
   public var id: String {
      self.name ?? ""
   }
}

#if DEBUG
   extension CategoryGroup {
      public static var mocked: CategoryGroup {
         .init(context: .mocked, name: "Project")
      }
   }
#endif
