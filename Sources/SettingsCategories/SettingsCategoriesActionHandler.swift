import ComposableArchitecture
import Foundation
import Model
import Utility

struct SettingsCategoriesActionHandler {
   typealias State = SettingsCategoriesState
   typealias Action = SettingsCategoriesAction
   typealias Next = Effect<Action, Never>

   let env: AppEnv

   func setEditCategory(state: inout State, isPresented: Bool) -> Next {
      state.editCategoryState = isPresented ? .init(group: state.selectedGroup, existingCategory: nil) : nil
      return .none
   }

   func deleteCategoryButtonPressed(state: inout State, category: Model.Category) -> Next {
      #warning("not yet implemented")
      return .none
   }

   func categoryNameChanged(state: inout State, category: Model.Category, name: String) -> Next {
      category.name = name
      try! env.managedObjectContext.save()
      #warning("handle errors instead of using a force try")
      return .none
   }
}
