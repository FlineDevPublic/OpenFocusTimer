import ComposableArchitecture
import Foundation

public enum SettingsEditCategoryAction: Equatable, BindableAction {
   case saveButtonPressed
   case cancelButtonPressed

   case binding(BindingAction<SettingsEditCategoryState>)
}
