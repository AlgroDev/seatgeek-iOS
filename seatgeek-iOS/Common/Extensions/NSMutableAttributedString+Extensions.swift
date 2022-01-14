//
//  NSMutableAttributedString+Extensions.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {

  internal var range: NSRange {
    NSRange(location: 0, length: length)
  }

  public func add(font: UIFont) -> NSMutableAttributedString {
    addAttribute(.font, value: font, range: range)

    return self
  }

  public func add(lineSpacing: CGFloat) -> NSMutableAttributedString {
    let paragraph = getParagraphStyle()
    paragraph.lineSpacing = lineSpacing
    addAttribute(.paragraphStyle, value: paragraph, range: range)

    return self
  }

  public func add(lineHeight: CGFloat) -> NSMutableAttributedString {
    let paragraph = getParagraphStyle()
    paragraph.minimumLineHeight = lineHeight
    paragraph.maximumLineHeight = lineHeight
    addAttribute(.paragraphStyle, value: paragraph, range: range)

    return self
  }

  public func add(color: UIColor) -> NSMutableAttributedString {
    addAttribute(.foregroundColor, value: color, range: range)

    return self
  }

  public func add(textAlignment: NSTextAlignment) -> NSMutableAttributedString {
    let paragraph = getParagraphStyle()
    paragraph.alignment = textAlignment
    addAttribute(.paragraphStyle, value: paragraph, range: range)

    return self
  }

  public func add(lettersSpacing: CGFloat) -> NSMutableAttributedString {
    addAttribute(.kern, value: lettersSpacing, range: range)

    return self
  }

  internal func getParagraphStyle() -> NSMutableParagraphStyle {
    let range: NSRange = NSRange(location: 0, length: length)
    var paragraphToReturn = NSMutableParagraphStyle()
    enumerateAttribute(.paragraphStyle, in: range, options: .longestEffectiveRangeNotRequired) { value, _, stop in
      if let paragraph = value as? NSMutableParagraphStyle {
        paragraphToReturn = paragraph
        stop.pointee = true
      }
    }

    return paragraphToReturn
  }
}
