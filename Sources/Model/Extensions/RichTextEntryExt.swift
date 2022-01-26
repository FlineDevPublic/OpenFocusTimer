import Foundation
import CoreData

extension RichTextEntry {
  public convenience init(
    context: NSManagedObjectContext,
    text: String
  ) {
    self.init(context: context)
    self.text = text
  }
}
