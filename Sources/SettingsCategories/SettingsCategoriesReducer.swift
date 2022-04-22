import ComposableArchitecture
import Foundation
import Utility

public let settingsCategoriesReducer = Reducer.combine(
   Reducer<SettingsCategoriesState, SettingsCategoriesAction, AppEnv> { state, action, env in
      let actionHandler = SettingsCategoriesActionHandler(env: env)

      switch action {
      case .createNewCategoryButtonPressed:
         return actionHandler.createNewCategoryButtoPressed(state: &state)

      case .deleteCategoryButtonPressed(let category):
         return actionHandler.deleteCategoryButtonPressed(state: &state, category: category)

      case .binding:
         return .none  // assignment handled by `.binding()` below
      }
   }
   .binding()
)
