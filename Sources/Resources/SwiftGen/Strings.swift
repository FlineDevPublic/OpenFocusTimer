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

  public enum Timer {
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
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
