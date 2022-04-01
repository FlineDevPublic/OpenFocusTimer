import ComposableArchitecture
import Model
import CoreData
import Utility

public let categoriesSelectorReducer = Reducer<
  CategoriesSelectorState, CategoriesSelectorAction, AppEnv
> { state, action, env in
  switch action {
  case let .categoryGroupSelectionChanged(group, category):
    #warning("selecting a different picker value results in a `nil` cateogyr -> crash")
    guard let category = category else { fatalError("Selecting a nil value shouldn't be possible in picker.") }

    for category in state.focusTimer.typedCategories where category.group == group {
      state.focusTimer.removeFromCategories(category)
    }

    state.focusTimer.addToCategories(category)
    try! env.managedObjectContext.save()

    // update view
    state.selectedGroupCategories[group] = category
  }

  return .none
}
