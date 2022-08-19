// swiftlint:disable all
// swift-format-ignore-file
// AnyLint.skipInFile: All

// This file is maintained by ReMafoX (https://remafox.app) – manual edits will be overridden.

import Foundation
import SwiftUI

/// Top-level shortcut for ``Res.Str``. Provides safe access to localized strings. Managed by ReMafoX (https://remafox.app).
public typealias Loc = Res.Str

/// Top-level namespace for safe resource access. Managed by ReMafoX (https://remafox.app).
public enum Res {
   /// Root namespace for safe access to localized strings. Managed by ReMafoX (https://remafox.app).
   public enum Str {
      public enum DatabaseSeeder {
         public enum MainProjectCategory {
            /// 🇺🇸 English: "Main Project"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.main_project_category.name" }
            }
         }

         public enum ProjectGroup {
            /// 🇺🇸 English: "Project"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.project_group.name" }
            }
         }

         public enum SideProjectCategory {
            /// 🇺🇸 English: "Side Project"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.side_project_category.name" }
            }
         }

         public enum TaskTypeCodeReview {
            /// 🇺🇸 English: "Code Review"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.task_type_code_review.name" }
            }
         }

         public enum TaskTypeDesign {
            /// 🇺🇸 English: "Design"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.task_type_design.name" }
            }
         }

         public enum TaskTypeGroup {
            /// 🇺🇸 English: "Task Type"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.task_type_group.name" }
            }
         }

         public enum TaskTypePaperwork {
            /// 🇺🇸 English: "Paperwork"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.task_type_paperwork.name" }
            }
         }

         public enum TaskTypeProgramming {
            /// 🇺🇸 English: "Programming"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.task_type_programming.name" }
            }
         }

         public enum TaskTypeResearch {
            /// 🇺🇸 English: "Research"
            public enum Name {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "database_seeder.task_type_research.name" }
            }
         }
      }

      public enum Global {
         public enum Action {
            /// 🇺🇸 English: "Cancel"
            public enum Cancel {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "global.action.cancel" }
            }

            /// 🇺🇸 English: "Close"
            public enum Close {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "global.action.close" }
            }

            /// 🇺🇸 English: "Delete"
            public enum Delete {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "global.action.delete" }
            }

            /// 🇺🇸 English: "OK"
            public enum Ok {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "global.action.ok" }
            }

            /// 🇺🇸 English: "Save"
            public enum Save {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "global.action.save" }
            }
         }

         public enum Label {
            /// 🇺🇸 English: "Are you sure?"
            public enum ConfirmActionTitle {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "global.label.confirm_action_title" }
            }
         }
      }

      public enum HistoryFeature {
         public enum EmptyState {
            /// 🇺🇸 English: "No timers recorded.\nTrack times to see something here."
            public enum Message {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "history_feature.empty_state.message" }
            }
         }

         public enum HistoryRow {
            /// 🇺🇸 English: "No focus topic"
            public enum EmptyTopic {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "history_feature.history_row.empty_topic" }
            }
         }

         /// 🇺🇸 English: "History"
         public enum NavigationTitle {
            /// The translated `String` instance.
            public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

            /// The SwiftUI `LocalizedStringKey` instance.
            public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

            /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
            public static var tableLookupKey: String { "history_feature.navigation_title" }
         }
      }

      public enum Main {
         public enum Detail {
            /// 🇺🇸 English: "No sidebar entry selected."
            public enum EmptyState {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "main.detail.empty_state" }
            }
         }

         public enum SidebarEntry {
            /// 🇺🇸 English: "History"
            public enum History {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "main.sidebar_entry.history" }
            }

            /// 🇺🇸 English: "Statistics"
            public enum Statistics {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "main.sidebar_entry.statistics" }
            }
         }
      }

      public enum Reflection {
         public enum LearningsSection {
            /// 🇺🇸 English: "e.g. Splitting meetings to multiple shorter ones"
            public enum Placeholder {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.learnings_section.placeholder" }
            }

            /// 🇺🇸 English: "Learnings / Ideas"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.learnings_section.title" }
            }
         }

         public enum NextStepsSection {
            /// 🇺🇸 English: "e.g. Add Japanese support to app"
            public enum Placeholder {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.next_steps_section.placeholder" }
            }

            /// 🇺🇸 English: "Next Steps / Continue Here"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.next_steps_section.title" }
            }
         }

         public enum ProblemsSection {
            /// 🇺🇸 English: "e.g. Didn't know where to start"
            public enum Placeholder {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.problems_section.placeholder" }
            }

            /// 🇺🇸 English: "Problems / Blockers"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.problems_section.title" }
            }
         }

         public enum ProgressSection {
            /// 🇺🇸 English: "e.g. Finished 1st version of App Icon"
            public enum Placeholder {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.progress_section.placeholder" }
            }

            /// 🇺🇸 English: "Progress / Summary"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "reflection.progress_section.title" }
            }
         }
      }

      public enum SettingsCategories {
         public enum CategoriesEmptyState {
            /// 🇺🇸 English: "No categories created yet. Click button below to create one."
            public enum Message {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.categories_empty_state.message" }
            }
         }

         public enum CreateNewCategoryButton {
            /// 🇺🇸 English: "Create new Category"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.create_new_category_button.title" }
            }
         }

         public enum DeleteConfirmDialog {
            /// 🇺🇸 English: "Do you really want to delete this category?"
            public enum Message {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.delete_confirm_dialog.message" }
            }
         }

         public enum EditCategory {
            /// 🇺🇸 English: "Select color:"
            public enum ColorLabel {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.edit_category.color_label" }
            }

            /// 🇺🇸 English: "Choose an icon:"
            public enum IconLabel {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.edit_category.icon_label" }
            }

            /// 🇺🇸 English: "Category Name:"
            public enum NameLabel {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.edit_category.name_label" }
            }

            /// 🇺🇸 English: "Enter name of the category here ..."
            public enum NamePlaceholder {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.edit_category.name_placeholder" }
            }
         }

         public enum GroupSelector {
            /// 🇺🇸 English: "Select the category group to edit:"
            public enum Label {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_categories.group_selector.label" }
            }
         }
      }

      public enum Settings {
         public enum CategoriesTab {
            /// 🇺🇸 English: "Categories"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings.categories_tab.title" }
            }
         }

         public enum CategoryGroupsTab {
            /// 🇺🇸 English: "Category Groups"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings.category_groups_tab.title" }
            }
         }

         public enum GeneralTab {
            /// 🇺🇸 English: "General"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings.general_tab.title" }
            }
         }
      }

      public enum SettingsCategoryGroups {
         public enum CreateNewGroupButton {
            /// 🇺🇸 English: "New Category Group"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_category_groups.create_new_group_button.title" }
            }
         }

         public enum DeleteConfirmDialog {
            /// 🇺🇸 English: "Do you really want to delete this category group?"
            public enum Message {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_category_groups.delete_confirm_dialog.message" }
            }
         }

         public enum EditCategoryGroup {
            /// 🇺🇸 English: "Group Name:"
            public enum NameLabel {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_category_groups.edit_category_group.name_label" }
            }

            /// 🇺🇸 English: "Enter name of the group here ..."
            public enum Placeholder {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_category_groups.edit_category_group.placeholder" }
            }
         }

         public enum EmptyState {
            /// 🇺🇸 English: "No category groups yet. Click button below to create one."
            public enum Message {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "settings_category_groups.empty_state.message" }
            }
         }
      }

      public enum Timer {
         public enum Action {
            /// 🇺🇸 English: "Continue"
            public enum Continue {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.action.continue" }
            }

            /// 🇺🇸 English: "Pause"
            public enum Pause {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.action.pause" }
            }

            /// 🇺🇸 English: "Start"
            public enum Start {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.action.start" }
            }
         }

         public enum EditCategoriesButton {
            /// 🇺🇸 English: "Edit Categories"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.edit_categories_button.title" }
            }
         }

         public enum EditCategoriesScreen {
            /// 🇺🇸 English: "Edit Categories"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.edit_categories_screen.title" }
            }
         }

         public enum EditSummaryButton {
            /// 🇺🇸 English: "Edit Summary"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.edit_summary_button.title" }
            }
         }

         public enum EditSummaryScreen {
            /// 🇺🇸 English: "Edit Summary"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.edit_summary_screen.title" }
            }
         }

         public enum TimeIsUpAlert {
            /// 🇺🇸 English: "It's time to take a break. Consider having a stretch & breathing some fresh air."
            public enum Message {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.time_is_up_alert.message" }
            }

            /// 🇺🇸 English: "Time is up!"
            public enum Title {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.time_is_up_alert.title" }
            }
         }

         public enum TimeLeft {
            /// 🇺🇸 English: "Time left:"
            public enum Label {
               /// The translated `String` instance.
               public static var string: String { Bundle.module.localizedString(forKey: self.tableLookupKey, value: nil, table: "Localizable") }

               /// The SwiftUI `LocalizedStringKey` instance.
               public static var locStringKey: LocalizedStringKey { LocalizedStringKey(self.tableLookupKey) }

               /// The lookup key in the translation table (= the key in the `.strings` or `.stringsdict` file).
               public static var tableLookupKey: String { "timer.time_left.label" }
            }
         }
      }
   }
}
