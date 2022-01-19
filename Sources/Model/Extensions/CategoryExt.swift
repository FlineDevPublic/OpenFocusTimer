import Foundation
import SwiftUI
import SFSafeSymbols

extension Category {
  public var color: Color {
    #warning("not yet implemented")
    return .white
  }

  public var iconImage: Image {
    Image(systemName: self.iconSymbolName!)
  }

  #warning("add group to the initializer")
  public convenience init(
    name: String,
    color: Color,
    icon: SFSymbol
  ) {
    self.init()

    self.name = name
    #warning("not yet implemented")
    self.colorHexCode = ""
    self.iconSymbolName = icon.rawValue
  }
}
