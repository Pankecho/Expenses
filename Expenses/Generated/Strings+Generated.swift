// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Auth {
    /// Email
    public static let email = L10n.tr("Localizable", "auth.email")
    /// mail@example.com
    public static let emailPlaceholder = L10n.tr("Localizable", "auth.emailPlaceholder")
    /// Password
    public static let password = L10n.tr("Localizable", "auth.password")
    public enum Button {
      /// Forgot Password?
      public static let forgotPassword = L10n.tr("Localizable", "auth.button.forgotPassword")
      /// Login
      public static let login = L10n.tr("Localizable", "auth.button.login")
      /// Signup
      public static let signup = L10n.tr("Localizable", "auth.button.signup")
      /// Login with: 
      public static let social = L10n.tr("Localizable", "auth.button.social")
    }
  }

  public enum Landing {
    /// Keep track of your expenses on credit cards
    public static let title = L10n.tr("Localizable", "landing.title")
    public enum Button {
      /// Login
      public static let login = L10n.tr("Localizable", "landing.button.login")
      /// Signup
      public static let signup = L10n.tr("Localizable", "landing.button.signup")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
