import ComposableArchitecture
import Foundation

public enum SettingsCategoriesAction: Equatable, BindableAction {
   // add Action cases here

   case binding(BindingAction<SettingsCategoriesState>)
}
