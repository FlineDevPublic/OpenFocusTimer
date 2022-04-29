import ComposableArchitecture
import Foundation
import Model

public enum SettingsCategoriesAction: Equatable, BindableAction {
   case createNewCategoryButtonPressed
   case deleteCategoryButtonPressed(category: Model.Category)
   case categoryNameChanged(category: Model.Category, name: String)

   case binding(BindingAction<SettingsCategoriesState>)
}
