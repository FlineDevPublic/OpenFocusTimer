import CoreData
import Foundation

@objc(Category)
public class Category: NSManagedObject {
   @nonobjc
   public class func fetchRequest() -> NSFetchRequest<Category> {
      NSFetchRequest<Category>(entityName: "Category")
   }

   @NSManaged
   public var colorHexCode: String?

   @NSManaged
   public var iconSymbolName: String?

   @NSManaged
   public var name: String?

   @NSManaged
   public var focusTimers: NSSet?

   @NSManaged
   public var group: CategoryGroup?
}

// MARK: Generated accessors for focusTimers
extension Category {
   @objc(addFocusTimersObject:)
   @NSManaged
   public func addToFocusTimers(_ value: FocusTimer)

   @objc(removeFocusTimersObject:)
   @NSManaged
   public func removeFromFocusTimers(_ value: FocusTimer)

   @objc(addFocusTimers:)
   @NSManaged
   public func addToFocusTimers(_ values: NSSet)

   @objc(removeFocusTimers:)
   @NSManaged
   public func removeFromFocusTimers(_ values: NSSet)
}
