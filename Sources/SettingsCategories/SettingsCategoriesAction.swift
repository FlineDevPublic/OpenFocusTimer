import ComposableArchitecture
import Foundation
import Model

public enum SettingsCategoriesAction: Equatable, BindableAction {
   case createNewCategoryButtonPressed
   case deleteCategoryButtonPressed(category: Model.Category)

   case binding(BindingAction<SettingsCategoriesState>)
}
