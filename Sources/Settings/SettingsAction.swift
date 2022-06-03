import ComposableArchitecture
import SettingsCategories
import SettingsCategoryGroups

#warning("🧑‍💻 provide a new actual 'stop' button for cancelling out early")
public enum SettingsAction: Equatable, BindableAction {
   case settingsCategories(action: SettingsCategoriesAction)
   case settingsCategoryGroups(action: SettingsCategoryGroupsAction)

   case binding(BindingAction<SettingsState>)
}
