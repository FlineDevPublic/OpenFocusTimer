import ComposableArchitecture
import Foundation
import HandySwift
import Model

public struct SettingsEditCategoryGroupState: Equatable {
   var existingCategoryGroup: Model.CategoryGroup?

   @BindableState
   var name: String

   @BindableState
   var showDeleteConfirmDialog = false

   public init(existingCategoryGroup: Model.CategoryGroup?) {
      self.existingCategoryGroup = existingCategoryGroup

      self.name = existingCategoryGroup?.name ?? ""
   }
}

#if DEBUG
   extension SettingsEditCategoryGroupState: Withable {}
#endif
