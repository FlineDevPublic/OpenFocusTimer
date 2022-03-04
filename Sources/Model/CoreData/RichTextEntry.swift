import Foundation
import CoreData

@objc(RichTextEntry)
public class RichTextEntry: NSManagedObject {
  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<RichTextEntry> {
    NSFetchRequest<RichTextEntry>(entityName: "RichTextEntry")
  }

  @NSManaged
  public var text: String?

  @NSManaged
  public var focusTimer: FocusTimer?
}
