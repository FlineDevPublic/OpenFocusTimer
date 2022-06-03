// swift-format-ignore-file
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// MARK: - Strings

public enum L10n {

   public enum DatabaseSeeder {
     public enum MainProjectCategory {
       /// Main Project
       public static let name = L10n.tr("Localizable", "database_seeder.main_project_category.name")
     }
     public enum ProjectGroup {
       /// Project
       public static let name = L10n.tr("Localizable", "database_seeder.project_group.name")
     }
     public enum SideProjectCategory {
       /// Side Project
       public static let name = L10n.tr("Localizable", "database_seeder.side_project_category.name")
     }
     public enum TaskTypeCodeReview {
       /// Code Review
       public static let name = L10n.tr("Localizable", "database_seeder.task_type_code_review.name")
     }
     public enum TaskTypeDesign {
       /// Design
       public static let name = L10n.tr("Localizable", "database_seeder.task_type_design.name")
     }
     public enum TaskTypeGroup {
       /// Task Type
       public static let name = L10n.tr("Localizable", "database_seeder.task_type_group.name")
     }
     public enum TaskTypePaperwork {
       /// Paperwork
       public static let name = L10n.tr("Localizable", "database_seeder.task_type_paperwork.name")
     }
     public enum TaskTypeProgramming {
       /// Programming
       public static let name = L10n.tr("Localizable", "database_seeder.task_type_programming.name")
     }
     public enum TaskTypeResearch {
       /// Research
       public static let name = L10n.tr("Localizable", "database_seeder.task_type_research.name")
     }
   }

   public enum Global {
     public enum Action {
       /// Cancel
       public static let cancel = L10n.tr("Localizable", "global.action.cancel")
       /// Close
       public static let close = L10n.tr("Localizable", "global.action.close")
       /// Delete
       public static let delete = L10n.tr("Localizable", "global.action.delete")
       /// OK
       public static let ok = L10n.tr("Localizable", "global.action.ok")
       /// Save
       public static let save = L10n.tr("Localizable", "global.action.save")
     }
     public enum Label {
       /// Are you sure?
       public static let confirmActionTitle = L10n.tr("Localizable", "global.label.confirm_action_title")
     }
   }

   public enum Reflection {
     public enum LearningsSection {
       /// e.g. Splitting meetings to multiple shorter ones
       public static let placeholder = L10n.tr("Localizable", "reflection.learnings_section.placeholder")
       /// Learnings / Ideas
       public static let title = L10n.tr("Localizable", "reflection.learnings_section.title")
     }
     public enum NextStepsSection {
       /// e.g. Add Japanese support to app
       public static let placeholder = L10n.tr("Localizable", "reflection.next_steps_section.placeholder")
       /// Next Steps / Continue Here
       public static let title = L10n.tr("Localizable", "reflection.next_steps_section.title")
     }
     public enum ProblemsSection {
       /// e.g. Didn't know where to start
       public static let placeholder = L10n.tr("Localizable", "reflection.problems_section.placeholder")
       /// Problems / Blockers
       public static let title = L10n.tr("Localizable", "reflection.problems_section.title")
     }
     public enum ProgressSection {
       /// e.g. Finished 1st version of App Icon
       public static let placeholder = L10n.tr("Localizable", "reflection.progress_section.placeholder")
       /// Progress / Summary
       public static let title = L10n.tr("Localizable", "reflection.progress_section.title")
     }
   }

   public enum Settings {
     public enum CategoriesTab {
       /// Categories
       public static let title = L10n.tr("Localizable", "settings.categories_tab.title")
     }
     public enum CategoryGroupsTab {
       /// Category Groups
       public static let title = L10n.tr("Localizable", "settings.category_groups_tab.title")
     }
     public enum GeneralTab {
       /// General
       public static let title = L10n.tr("Localizable", "settings.general_tab.title")
     }
   }

   public enum SettingsCategories {
     public enum CategoriesEmptyState {
       /// No categories created yet. Click button below to create one.
       public static let message = L10n.tr("Localizable", "settings_categories.categories_empty_state.message")
     }
     public enum CreateNewCategoryButton {
       /// Create new Category
       public static let title = L10n.tr("Localizable", "settings_categories.create_new_category_button.title")
     }
     public enum DeleteConfirmDialog {
       /// Do you really want to delete this category?
       public static let message = L10n.tr("Localizable", "settings_categories.delete_confirm_dialog.message")
     }
     public enum EditCategory {
       /// Select color:
       public static let colorLabel = L10n.tr("Localizable", "settings_categories.edit_category.color_label")
       /// Choose an icon:
       public static let iconLabel = L10n.tr("Localizable", "settings_categories.edit_category.icon_label")
       /// Category Name:
       public static let nameLabel = L10n.tr("Localizable", "settings_categories.edit_category.name_label")
       /// Enter name of the category here ...
       public static let namePlaceholder = L10n.tr("Localizable", "settings_categories.edit_category.name_placeholder")
     }
     public enum GroupSelector {
       /// Select the category group to edit:
       public static let label = L10n.tr("Localizable", "settings_categories.group_selector.label")
     }
   }

   public enum Timer {
     public enum Action {
       /// Continue
       public static let `continue` = L10n.tr("Localizable", "timer.action.continue")
       /// Pause
       public static let pause = L10n.tr("Localizable", "timer.action.pause")
       /// Start
       public static let start = L10n.tr("Localizable", "timer.action.start")
     }
     public enum EditCategoriesButton {
       /// Edit Categories
       public static let title = L10n.tr("Localizable", "timer.edit_categories_button.title")
     }
     public enum EditCategoriesScreen {
       /// Edit Categories
       public static let title = L10n.tr("Localizable", "timer.edit_categories_screen.title")
     }
     public enum EditSummaryButton {
       /// Edit Summary
       public static let title = L10n.tr("Localizable", "timer.edit_summary_button.title")
     }
     public enum EditSummaryScreen {
       /// Edit Summary
       public static let title = L10n.tr("Localizable", "timer.edit_summary_screen.title")
     }
     public enum TimeIsUpAlert {
       /// It's time to take a break. Consider having a stretch & breathing some fresh air.
       public static let message = L10n.tr("Localizable", "timer.time_is_up_alert.message")
       /// Time is up!
       public static let title = L10n.tr("Localizable", "timer.time_is_up_alert.title")
     }
     public enum TimeLeft {
       /// Time left:
       public static let label = L10n.tr("Localizable", "timer.time_left.label")
     }
   }
}

// MARK: - Implementation Details

extension L10n {
   private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
      let format = Bundle.swiftUIPreviewsCompatibleModule.localizedString(forKey: key, value: nil, table: table)
      return String(format: format, locale: Locale.current, arguments: args)
   }
}
