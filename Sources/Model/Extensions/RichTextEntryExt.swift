import Foundation
import CoreData

extension RichTextEntry {
  public convenience init(
    context: NSManagedObjectContext,
    text: String,
    focusTimer: FocusTimer
  ) {
    self.init(context: context)
    self.text = text
    self.focusTimer = focusTimer
  }
}
