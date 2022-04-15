import CoreData
import Foundation

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
