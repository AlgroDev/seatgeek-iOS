// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
public enum L10n {
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    let countString =  format.components(separatedBy:"%@").count - 1
    let countDecimals =  format.components(separatedBy:"%d").count - 1
    if countString + countDecimals > args.count || countString + countDecimals < args.count {
      #if DEBUG
        print("Translation Warning: This key \"\(key)\" is not well formatted !!!!!")
      #endif
      return key
    }

    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
