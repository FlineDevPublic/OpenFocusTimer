import ComposableArchitecture
import Foundation
import Model

public enum SettingsEditCategoryAction: Equatable, BindableAction {
   case saveButtonPressed
   case cancelButtonPressed
   case deleteButtonPressed
   case deleteConfirmed(category: Model.Category)

   case binding(BindingAction<SettingsEditCategoryState>)
}
