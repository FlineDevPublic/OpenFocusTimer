// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Global {
    public enum Action {
      /// OK
      public static let ok = L10n.tr("Localizable", "global.action.ok")
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

  public enum Timer {
    public enum Action {
      /// Continue
      public static let `continue` = L10n.tr("Localizable", "timer.action.continue")
      /// Pause
      public static let pause = L10n.tr("Localizable", "timer.action.pause")
      /// Start
      public static let start = L10n.tr("Localizable", "timer.action.start")
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
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.swiftUIPreviewsCompatibleModule.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
