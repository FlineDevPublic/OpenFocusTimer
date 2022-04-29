import ComposableArchitecture
import Foundation

public enum SettingsEditCategoryAction: Equatable, BindableAction {
   case saveButtonPressed

   case binding(BindingAction<SettingsEditCategoryState>)
}
