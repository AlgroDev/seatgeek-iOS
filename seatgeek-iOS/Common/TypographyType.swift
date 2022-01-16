//
//  TypographyType.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

private enum TypographyFontSize {
  static let h1: CGFloat = 34
  static let h1Ipad: CGFloat = 46
  static let h2: CGFloat = 28
  static let h2Ipad: CGFloat = 24
  static let title1: CGFloat = 22
  static let title1Ipad: CGFloat = 24
  static let title2: CGFloat = 20
  static let title2Ipad: CGFloat = 20
  static let subtitle: CGFloat = 17
  static let subtitleIpad: CGFloat = 16
  static let body1: CGFloat = 17
  static let body1Ipad: CGFloat = 16
  static let body2: CGFloat = 15
  static let body2Ipad: CGFloat = 14
  static let body3: CGFloat = 13
  static let body3Ipad: CGFloat = 12
  static let body3Strong: CGFloat = 13
  static let body3StrongIpad: CGFloat = 12
  static let cta: CGFloat = 16
  static let ctaIpad: CGFloat = 12
  static let caption: CGFloat = 12
  static let captionIpad: CGFloat = 11
  static let chip: CGFloat = 11
  static let chipIpad: CGFloat = 12
}

private protocol TypographyFontProtocol {
  var font: UIFont { get }
}

private var typographyTypeFontMapping: [TypographyType: TypographyFontProtocol] {
  return [
    .h2: Header2(),
    .title1: Title1(),
    .title2: Title2(),
    .subtitle: Subtitle(),
    .body1: Body1(),
    .body2: Body2(),
    .body3: Body3(),
    .body3Strong: Body3Strong(),
    .cta: CTA(),
    .caption: Caption(),
    .chip: CHIP()
  ]
}

public enum TypographyType {
  case h1
  case h2
  case title1
  case title2
  case title3Emphasis
  case subtitle
  case body1
  case body2
  case body3
  case body3Strong
  case cta
  case caption
  case chip

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

private struct Header2: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextBold(size: TypographyFontSize.h1Ipad)
    }
    return .sfProTextBold(size: TypographyFontSize.h2)
  }
}

private struct Title1: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextBold(size: TypographyFontSize.title1Ipad)
    }
    return .sfProTextBold(size: TypographyFontSize.title1)
  }
}

private struct Title2: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextBold(size: TypographyFontSize.title2Ipad)
    }
    return .sfProTextBold(size: TypographyFontSize.title2)
  }
}

private struct Subtitle: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextSemibold(size: TypographyFontSize.subtitleIpad)
    }
    return .sfProTextSemibold(size: TypographyFontSize.subtitle)
  }
}

private struct Body1: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextRegular(size: TypographyFontSize.body1Ipad)
    }
    return .sfProTextRegular(size: TypographyFontSize.body1)
  }
}

private struct Body2: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextRegular(size: TypographyFontSize.body2Ipad)
    }
    return .sfProTextRegular(size: TypographyFontSize.body2)
  }
}

private struct CTA: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextMedium(ofSize: TypographyFontSize.ctaIpad)
    }
    return .sfProTextMedium(ofSize: TypographyFontSize.cta)
  }
}

private struct Body3: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextRegular(size: TypographyFontSize.body3Ipad)
    }
    return .sfProTextRegular(size: TypographyFontSize.body3)
  }
}

private struct Body3Strong: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextSemibold(size: TypographyFontSize.body3StrongIpad)
    }
    return .sfProTextSemibold(size: TypographyFontSize.body3Strong)
  }
}

private struct Caption: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextRegular(size: TypographyFontSize.captionIpad)
    }
    return .sfProTextRegular(size: TypographyFontSize.caption)
  }
}

private struct CHIP: TypographyFontProtocol {
  var font: UIFont {
    if UIDevice.current.userInterfaceIdiom == .pad {
      return .sfProTextSemibold(size: TypographyFontSize.chipIpad)
    }
    return .sfProTextSemibold(size: TypographyFontSize.chip)
  }
}

