import Foundation
import SwiftUI
import SFSafeSymbols
import CoreData

extension Category {
  public var color: Color {
    Color(hexString: self.colorHexCode!)
  }

  public var iconImage: Image {
    Image(systemName: self.iconSymbolName!)
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