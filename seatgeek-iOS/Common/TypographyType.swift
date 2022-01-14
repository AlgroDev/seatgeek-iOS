//
//  TypographyType.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

private enum TypographyFontSize {
  static let errorDescription: CGFloat = 22
  static let errorTitleButton: CGFloat = 17

}

private protocol TypographyFontProtocol {
  var font: UIFont { get }
}

private var typographyTypeFontMapping: [TypographyType: TypographyFontProtocol] {
  return [
    .errorDescription: ErrorDescription(),
    .errorTitleButton: ErrorTitleButton()
  ]
}

public enum TypographyType {
  case errorDescription
  case errorTitleButton

  var font: UIFont {
    guard let associatedFont = typographyTypeFontMapping[self] else { return UIFont.systemFont(ofSize: 15.0) }
    return associatedFont.font
  }
}


public struct Typography {}

public extension Typography {
  struct Label {
    public let underlyingStyle: UIViewStyle<UILabel>

    public static func compose(_ styles: Label...) -> Label {
      Label(underlyingStyle: UIViewStyle<UILabel> { view in
        for style in styles {
          style.underlyingStyle.styling(view)
        }
      })
    }

    public func apply(to label: UILabel) {
      underlyingStyle.apply(to: label)
    }

    // MARK: - Font

    private static func labelStyle(withType type: TypographyType) -> Label {
      Label(underlyingStyle: UIViewStyle<UILabel> { $0.font = type.font })
    }

    // MARK: - Text color

    private static func coloredText(_ color: UIColor) -> Label {
      Label(underlyingStyle: UIViewStyle<UILabel> { $0.textColor = color })
    }

    // MARK: - Text alignment

    private static func alignedText(_ alignment: NSTextAlignment) -> Label {
      Label(underlyingStyle: UIViewStyle<UILabel> { $0.textAlignment = alignment })
    }

    // MARK: - Line break mode

    private static func lineBreakedText(_ lineBreakMode: NSLineBreakMode) -> Label {
      Label(underlyingStyle: UIViewStyle<UILabel> { $0.lineBreakMode = lineBreakMode })
    }

    // MARK: - Typo

    public static func style(withType type: TypographyType, color: UIColor) -> Label {
      .compose(labelStyle(withType: type), coloredText(color))
    }

    public static func style(withType type: TypographyType, color: UIColor, alignment: NSTextAlignment) -> Label {
      .compose(labelStyle(withType: type), coloredText(color), alignedText(alignment))
    }

    public static func style(withAlignment alignment: NSTextAlignment) -> Label {
      .compose(alignedText(alignment))
    }

    public static func style(withLineBreakMode lineBreakMode: NSLineBreakMode) -> Label {
      .compose(lineBreakedText(lineBreakMode))
    }

    public static func style(withType type: TypographyType,
                             color: UIColor,
                             alignment: NSTextAlignment,
                             lineBreakMode: NSLineBreakMode) -> Label {
      .compose(labelStyle(withType: type),
               coloredText(color),
               alignedText(alignment),
               lineBreakedText(lineBreakMode))
    }
  }

  struct AttributedString {
    public let underlyingStyle: UIViewStyle<NSMutableAttributedString>

    public static func compose(_ styles: AttributedString...) -> AttributedString {
      AttributedString(underlyingStyle: UIViewStyle<NSMutableAttributedString> { attributedString in
        for style in styles {
          style.underlyingStyle.styling(attributedString)
        }
      })
    }

    public func apply(to attributedString: NSMutableAttributedString) {
      underlyingStyle.apply(to: attributedString)
    }

    // MARK: - Font

    private static func attributedStyle(withType type: TypographyType) -> AttributedString {
      AttributedString(
        underlyingStyle: UIViewStyle<NSMutableAttributedString> {
          $0.addAttribute(.font, value: type.font, range: $0.range)
        }
      )
    }

    // MARK: - Foreground color

    private static func coloredText(_ color: UIColor) -> AttributedString {
      AttributedString(underlyingStyle: UIViewStyle<NSMutableAttributedString> {
        $0.addAttribute(.foregroundColor, value: color, range: $0.range)
      })
    }

    // MARK: - Text alignment

    private static func alignedText(_ alignment: NSTextAlignment) -> AttributedString {
      AttributedString(underlyingStyle: UIViewStyle<NSMutableAttributedString> {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        $0.addAttribute(.paragraphStyle, value: paragraphStyle, range: $0.range)
      })
    }

    // MARK: - Line break mode

    private static func lineBreakedText(_ lineBreakMode: NSLineBreakMode) -> AttributedString {
      AttributedString(underlyingStyle: UIViewStyle<NSMutableAttributedString> {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        $0.addAttribute(.paragraphStyle, value: paragraphStyle, range: $0.range)
      })
    }

    // MARK: - Typo

    public static func style(withType type: TypographyType, color: UIColor) -> AttributedString {
      .compose(attributedStyle(withType: type), coloredText(color))
    }

    public static func style(withType type: TypographyType, color: UIColor, alignment: NSTextAlignment) -> AttributedString {
      .compose(attributedStyle(withType: type), coloredText(color), alignedText(alignment))
    }

    public static func style(withAlignment alignment: NSTextAlignment) -> AttributedString {
      .compose(alignedText(alignment))
    }

    public static func style(withLineBreakMode lineBreakMode: NSLineBreakMode) -> AttributedString {
      .compose(lineBreakedText(lineBreakMode))
    }

    public static func style(withType type: TypographyType,
                             color: UIColor,
                             alignment: NSTextAlignment,
                             lineBreakMode: NSLineBreakMode) -> AttributedString {
      .compose(attributedStyle(withType: type),
               coloredText(color),
               alignedText(alignment),
               lineBreakedText(lineBreakMode))
    }
  }

  struct Button {
    public let underlyingStyle: UIViewStyle<UIButton>

    public static func compose(_ styles: Button...) -> Button {
      Button(underlyingStyle: UIViewStyle<UIButton> { view in
        for style in styles {
          style.underlyingStyle.styling(view)
        }
      })
    }

    public func apply(to button: UIButton) {
      underlyingStyle.apply(to: button)
    }

    // MARK: - Font

    private static func buttonStyle(withType type: TypographyType) -> Button {
      Button(underlyingStyle: UIViewStyle<UIButton> { $0.titleLabel?.font = type.font })
    }

    // MARK: - Text color

    private static func coloredText(_ color: UIColor) -> Button {
      Button(underlyingStyle: UIViewStyle<UIButton> { $0.setTitleColor(color, for: .normal) })
    }

    // MARK: - Text alignment

    private static func alignedText(_ alignment: NSTextAlignment) -> Button {
      Button(underlyingStyle: UIViewStyle<UIButton> { $0.titleLabel?.textAlignment = alignment })
    }

    // MARK: - Line break mode

    private static func lineBreakedText(_ lineBreakMode: NSLineBreakMode) -> Button {
      Button(underlyingStyle: UIViewStyle<UIButton> { $0.titleLabel?.lineBreakMode = lineBreakMode })
    }

    // MARK: - Typo

    public static func style(withType type: TypographyType, color: UIColor) -> Button {
      .compose(buttonStyle(withType: type), coloredText(color))
    }

    public static func style(withType type: TypographyType, color: UIColor, alignment: NSTextAlignment) -> Button {
      .compose(buttonStyle(withType: type), coloredText(color), alignedText(alignment))
    }

    public static func style(withAlignment alignment: NSTextAlignment) -> Button {
      .compose(alignedText(alignment))
    }

    public static func style(withLineBreakMode lineBreakMode: NSLineBreakMode) -> Button {
      .compose(lineBreakedText(lineBreakMode))
    }

    public static func style(withType type: TypographyType,
                             color: UIColor,
                             alignment: NSTextAlignment,
                             lineBreakMode: NSLineBreakMode) -> Button {
      .compose(buttonStyle(withType: type),
               coloredText(color),
               alignedText(alignment),
               lineBreakedText(lineBreakMode))
    }
  }
}
// MARK: - Fonts

private struct ErrorDescription: TypographyFontProtocol {
  var font: UIFont {
    return UIFont.systemFont(ofSize: TypographyFontSize.errorDescription)
  }
}

private struct ErrorTitleButton: TypographyFontProtocol {
  var font: UIFont {
    return UIFont.systemFont(ofSize: TypographyFontSize.errorTitleButton)
  }
}
