import ComposableArchitecture
import Foundation
import SettingsEditCategoryGroup
import Utility

public let settingsCategoryGroupsReducer = Reducer.combine(
   settingsEditCategoryGroupReducer
      .optional()
      .pullback(
         state: \SettingsCategoryGroupsState.editCategoryGroupState,
         action: /SettingsCategoryGroupsAction.editCategoryGroup(action:),
         environment: { $0 }
      ),
   Reducer<SettingsCategoryGroupsState, SettingsCategoryGroupsAction, AppEnv> { state, action, env in
      let actionHandler = SettingsCategoryGroupsActionHandler(env: env)

      switch action {
      case .createNewCategoryGroupButtonPressed:
         return .init(value: .setEditCategoryGroup(isPresented: true))

      case .editCategoryGroup(action: .saveButtonPressed):
         return actionHandler.editCategoryGroupSaveButtonPressed(state: &state)

      case .editCategoryGroup(action: .cancelButtonPressed):
         return .init(value: .setEditCategoryGroup(isPresented: false))

      case .editCategoryGroup(action: .deleteConfirmed(let categoryGroup)):
         state.categoryGroupAwaitingDeleteConfirmation = categoryGroup
         return actionHandler.deleteCategoryGroupConfirmed(state: &state)

      case .editCategoryGroupButtonPressed(let categoryGroup):
         return actionHandler.editCategoryGroupButtonPressed(state: &state, categoryGroup: categoryGroup)

      case .deleteCategoryGroupButtonPressed(let categoryGroup):
         return actionHandler.deleteCategoryGroupButtonPressed(state: &state, categoryGroup: categoryGroup)

      case .deleteCategoryGroupConfirmed:
         return actionHandler.deleteCategoryGroupConfirmed(state: &state)

      case .editCategoryGroup:
         return .none  // handled by child reducer

      case .setEditCategoryGroup(let isPresented):
         return actionHandler.setEditCategoryGroup(state: &state, isPresented: isPresented)

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
