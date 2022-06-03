import ComposableArchitecture
import Foundation

public enum SettingsCategoryGroupsAction: Equatable, BindableAction {
   // add Action cases here

   case binding(BindingAction<SettingsCategoryGroupsState>)
}
