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

  func apply(font: UIFont, color: UIColor) {
    apply(font: font)
    apply(color: color)
  }

  func apply(font: UIFont, color: UIColor, alignment: NSTextAlignment) {
    apply(font: font)
    apply(color: color)
    apply(alignment: alignment)
  }

  func apply(alignment: NSTextAlignment) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
  }

  func apply(color: UIColor) {
    addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: length))
  }

  func apply(font: UIFont) {
    addAttribute(.font, value: font, range: NSRange(location: 0, length: length))
  }
}
