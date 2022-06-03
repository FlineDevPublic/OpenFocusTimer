import ComposableArchitecture
import Foundation
import Model

public enum SettingsEditCategoryGroupAction: Equatable, BindableAction {
   case saveButtonPressed
   case cancelButtonPressed
   case deleteButtonPressed
   case deleteConfirmed(categoryGroup: Model.CategoryGroup)

   case binding(BindingAction<SettingsEditCategoryGroupState>)
}
