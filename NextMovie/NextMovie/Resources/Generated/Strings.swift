// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum Localization {
  /// Add
  internal static let add = Localization.tr("Localizable", "ADD")
  /// Auto Play
  internal static let autoPlay = Localization.tr("Localizable", "AUTO_PLAY")
  /// Turn on the functionality of play automatically movie trailer
  internal static let autoPlayDescription = Localization.tr("Localizable", "AUTO_PLAY_DESCRIPTION")
  /// Cancel
  internal static let cancel = Localization.tr("Localizable", "CANCEL")
  /// Category
  internal static let category = Localization.tr("Localizable", "CATEGORY")
  /// Choose from gallery
  internal static let chooseFromGallery = Localization.tr("Localizable", "CHOOSE_FROM_GALLERY")
  /// Dark Mode
  internal static let darkMode = Localization.tr("Localizable", "DARK_MODE")
  /// Changes app theme to dark
  internal static let darkModeDescription = Localization.tr("Localizable", "DARK_MODE_DESCRIPTION")
  /// Edit movie
  internal static let editMovie = Localization.tr("Localizable", "EDIT_MOVIE")
  /// Name of category
  internal static let nameOfCategory = Localization.tr("Localizable", "NAME_OF_CATEGORY")
  /// Ok
  internal static let ok = Localization.tr("Localizable", "OK")
  /// Reminder created at
  internal static let reminderCreatedAt = Localization.tr("Localizable", "REMINDER_CREATED_AT")
  /// Reminder to watch
  internal static let reminderToWatch = Localization.tr("Localizable", "REMINDER_TO_WATCH")
  /// Save
  internal static let save = Localization.tr("Localizable", "SAVE")
  /// Settings
  internal static let settings = Localization.tr("Localizable", "SETTINGS")
  /// Write some comentary
  internal static let writeSomeComentary = Localization.tr("Localizable", "WRITE_SOME_COMENTARY")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
