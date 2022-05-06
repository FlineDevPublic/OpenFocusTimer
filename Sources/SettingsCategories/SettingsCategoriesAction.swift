import ComposableArchitecture
import Foundation
import Model
import SettingsEditCategory

public enum SettingsCategoriesAction: Equatable, BindableAction {
   case createNewCategoryButtonPressed

   case editCategoryButtonPressed(category: Model.Category)
   case deleteCategoryButtonPressed(category: Model.Category)

   case editCategory(action: SettingsEditCategoryAction)
   case setEditCategory(isPresented: Bool)

   case binding(BindingAction<SettingsCategoriesState>)
}
