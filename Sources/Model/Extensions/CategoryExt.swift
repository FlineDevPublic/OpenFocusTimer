import Foundation
import SwiftUI
import SFSafeSymbols

extension Category {
  public var color: Color {
    Color(hexString: self.colorHexCode!)
  }

  public var iconImage: Image {
    Image(systemName: self.iconSymbolName!)
  }

  public convenience init(
    name: String,
    color: Color,
    icon: SFSymbol,
    group: CategoryGroup
  ) {
    self.init()

    self.name = name
    self.colorHexCode = color.hexString
    self.iconSymbolName = icon.rawValue
    self.group = group
  }
}
