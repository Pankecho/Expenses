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
    public enum Alert {
      /// Error
      public static let title = L10n.tr("Localizable", "auth.alert.title")
      public enum Button {
        /// Accept
        public static let ok = L10n.tr("Localizable", "auth.alert.button.ok")
      }
    }
    public enum Button {
      /// Already have an account? Login
      public static let alreadyHaveAccount = L10n.tr("Localizable", "auth.button.alreadyHaveAccount")
      /// Don't have an account? Signup
      public static let dontHaveAccount = L10n.tr("Localizable", "auth.button.dontHaveAccount")
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

  public enum Cards {
    public enum Add {
      /// Bank
      public static let bank = L10n.tr("Localizable", "cards.add.bank")
      /// Card Type
      public static let cardType = L10n.tr("Localizable", "cards.add.cardType")
      /// Closing Day
      public static let closingDay = L10n.tr("Localizable", "cards.add.closingDay")
      /// Credit Limit
      public static let creditLimit = L10n.tr("Localizable", "cards.add.creditLimit")
      /// Pay Limit Day
      public static let limitDay = L10n.tr("Localizable", "cards.add.limitDay")
      /// Name
      public static let name = L10n.tr("Localizable", "cards.add.name")
      public enum Button {
        /// Save card
        public static let save = L10n.tr("Localizable", "cards.add.button.save")
      }
    }
    public enum List {
      /// Cards
      public static let title = L10n.tr("Localizable", "cards.list.title")
      public enum Empty {
        /// Ooops, it looks like you don't have any cards added.
        public static let title = L10n.tr("Localizable", "cards.list.empty.title")
      }
    }
  }

  public enum Expenses {
    public enum Add {
      /// Amount
      public static let amount = L10n.tr("Localizable", "expenses.add.amount")
      /// Card
      public static let card = L10n.tr("Localizable", "expenses.add.card")
      /// Date
      public static let date = L10n.tr("Localizable", "expenses.add.date")
      /// Description
      public static let description = L10n.tr("Localizable", "expenses.add.description")
      /// Expense Type
      public static let expenseType = L10n.tr("Localizable", "expenses.add.expenseType")
      public enum Alert {
        /// Error
        public static let title = L10n.tr("Localizable", "expenses.add.alert.title")
        public enum Button {
          /// Accept
          public static let ok = L10n.tr("Localizable", "expenses.add.alert.button.ok")
        }
      }
      public enum Button {
        /// Save
        public static let save = L10n.tr("Localizable", "expenses.add.button.save")
      }
    }
    public enum List {
      /// Expenses
      public static let title = L10n.tr("Localizable", "expenses.list.title")
      public enum Empty {
        /// Ooops, it looks like you don't have any expenses yet.
        public static let title = L10n.tr("Localizable", "expenses.list.empty.title")
      }
    }
  }

  public enum Filters {
    public enum Month {
      /// April
      public static let april = L10n.tr("Localizable", "filters.month.april")
      /// August
      public static let august = L10n.tr("Localizable", "filters.month.august")
      /// December
      public static let december = L10n.tr("Localizable", "filters.month.december")
      /// February
      public static let february = L10n.tr("Localizable", "filters.month.february")
      /// January
      public static let january = L10n.tr("Localizable", "filters.month.january")
      /// March
      public static let march = L10n.tr("Localizable", "filters.month.march")
      /// May
      public static let may = L10n.tr("Localizable", "filters.month.may")
      /// November
      public static let november = L10n.tr("Localizable", "filters.month.november")
      /// October
      public static let october = L10n.tr("Localizable", "filters.month.october")
      /// September
      public static let september = L10n.tr("Localizable", "filters.month.september")
    }
  }

  public enum Home {
    public enum Tabs {
      /// Cards
      public static let cardsTitle = L10n.tr("Localizable", "home.tabs.cardsTitle")
      /// Expenses
      public static let expensesTitle = L10n.tr("Localizable", "home.tabs.expensesTitle")
      /// Settings
      public static let settingsTitle = L10n.tr("Localizable", "home.tabs.settingsTitle")
    }
  }

  public enum Landing {
    /// Keep track of your expenses on credit cards
    public static let title = L10n.tr("Localizable", "landing.title")
    public enum Button {
      /// Next
      public static let next = L10n.tr("Localizable", "landing.button.next")
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
