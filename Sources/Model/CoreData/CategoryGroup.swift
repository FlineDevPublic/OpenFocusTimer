import Foundation
import CoreData

@objc(CategoryGroup)
public class CategoryGroup: NSManagedObject {
  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<CategoryGroup> {
    NSFetchRequest<CategoryGroup>(entityName: "CategoryGroup")
  }

  @NSManaged
  public var name: String?

  @NSManaged
  public var categories: NSSet?
}

// MARK: Generated accessors for categories
extension CategoryGroup {
  @objc(addCategoriesObject:)
  @NSManaged public func addToCategories(_ value: Category)

  @objc(removeCategoriesObject:)
  @NSManaged public func removeFromCategories(_ value: Category)

  @objc(addCategories:)
  @NSManaged public func addToCategories(_ values: NSSet)

  @objc(removeCategories:)
  @NSManaged public func removeFromCategories(_ values: NSSet)
}
