import CoreData
import Foundation
import SFSafeSymbols
import SwiftUI

extension Category {
   public var typedFocusTimers: Set<FocusTimer> {
      get {
         self.focusTimers as! Set<FocusTimer>? ?? []
      }

      set {
         self.focusTimers = NSSet(set: newValue)
      }
   }

   public var color: Color {
      Color(hexString: self.colorHexCode ?? "#000000")
   }

   public var iconImage: Image {
      Image(systemName: self.iconSymbolName ?? "circle")
   }

   public convenience init(
      context: NSManagedObjectContext,
      name: String,
      color: Color,
      icon: SFSymbol,
      group: CategoryGroup
   ) {
      self.init(context: context)

      self.name = name
      self.colorHexCode = color.hexString
      self.iconSymbolName = icon.rawValue
      self.group = group
   }
}

#warning("🧑‍💻 make sure to use a proper identifier, e.g. the name could be made unique")
extension Category: Identifiable {
   public var id: String {
      self.name ?? ""
   }
}
