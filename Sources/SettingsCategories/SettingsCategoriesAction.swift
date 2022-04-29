import ComposableArchitecture
import Foundation
import Model
import SettingsEditCategory

public enum SettingsCategoriesAction: Equatable, BindableAction {
   case createNewCategoryButtonPressed

   case deleteCategoryButtonPressed(category: Model.Category)
   case categoryNameChanged(category: Model.Category, name: String)

   case editCategory(action: SettingsEditCategoryAction)
   case setEditCategory(isPresented: Bool)

   case binding(BindingAction<SettingsCategoriesState>)
}
