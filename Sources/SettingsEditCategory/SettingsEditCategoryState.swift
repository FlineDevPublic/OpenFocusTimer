import ComposableArchitecture
import Foundation
import HandySwift
import Model
import SFSafeSymbols
import SwiftUI

public struct SettingsEditCategoryState: Equatable {
   let group: CategoryGroup

   #warning("changing data when this is non-nil is not yet implemented")
   var existingCategory: Model.Category?

   @BindableState
   var name: String

   @BindableState
   var color: Color

   @BindableState
   var icon: SFSymbol

   public init(group: CategoryGroup, existingCategory: Model.Category?) {
      self.group = group
      self.existingCategory = existingCategory

      self.name = existingCategory?.name ?? ""
      #warning("smartly suggest a non-used color from a list of nice colors")
      self.color = existingCategory?.color ?? .gray

      if let existingIconSymbolName = existingCategory?.iconSymbolName {
         self.icon = SFSymbol(rawValue: existingIconSymbolName)
      } else {
         self.icon = .questionmark
      }
   }
}

#if DEBUG
   extension SettingsEditCategoryState: Withable {}
#endif
