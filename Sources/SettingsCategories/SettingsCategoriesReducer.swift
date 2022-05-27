import ComposableArchitecture
import Foundation
import SettingsEditCategory
import Utility

public let settingsCategoriesReducer = Reducer.combine(
   settingsEditCategoryReducer
      .optional()
      .pullback(
         state: \SettingsCategoriesState.editCategoryState,
         action: /SettingsCategoriesAction.editCategory(action:),
         environment: { $0 }
      ),
   Reducer<SettingsCategoriesState, SettingsCategoriesAction, AppEnv> { state, action, env in
      let actionHandler = SettingsCategoriesActionHandler(env: env)

      switch action {
      case .createNewCategoryButtonPressed:
         return .init(value: .setEditCategory(isPresented: true))

      case .editCategory(action: .saveButtonPressed):
         return actionHandler.editCategorySaveButtonPressed(state: &state)

      case .editCategory(action: .cancelButtonPressed):
         return .init(value: .setEditCategory(isPresented: false))

      case .editCategory(action: .deleteConfirmed(let category)):
         state.categoryAwaitingDeleteConfirmation = category
         return actionHandler.deleteCategoryConfirmed(state: &state)

      case .editCategoryButtonPressed(let category):
         return actionHandler.editCategoryButtonPressed(state: &state, category: category)

      case .deleteCategoryButtonPressed(let category):
         return actionHandler.deleteCategoryButtonPressed(state: &state, category: category)

      case .deleteCategoryConfirmed:
         return actionHandler.deleteCategoryConfirmed(state: &state)

      case .editCategory:
         return .none  // handled by child reducer

      case .setEditCategory(let isPresented):
         return actionHandler.setEditCategory(state: &state, isPresented: isPresented)

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
