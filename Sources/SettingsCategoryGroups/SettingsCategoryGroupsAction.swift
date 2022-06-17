import ComposableArchitecture
import Foundation
import Model
import SettingsEditCategoryGroup

public enum SettingsCategoryGroupsAction: Equatable, BindableAction {
   case createNewCategoryGroupButtonPressed

   case editCategoryGroupButtonPressed(categoryGroup: Model.CategoryGroup)
   case deleteCategoryGroupButtonPressed(categoryGroup: Model.CategoryGroup)
   case deleteCategoryGroupConfirmed

   case editCategoryGroup(action: SettingsEditCategoryGroupAction)
   case setEditCategoryGroup(isPresented: Bool)

   case categoryGroupsChanged

   case binding(BindingAction<SettingsCategoryGroupsState>)
}
