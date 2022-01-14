//
//  AttributedStringConvertible.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

typealias Styles = (type: TypographyType, color: UIColor)

protocol AttributedStringConvertible {
  func convertText(_ text: String, style: Styles) -> NSAttributedString
}

extension AttributedStringConvertible {
  func convertText(_ text: String, style: Styles) -> NSAttributedString {
    let conversion = NSMutableAttributedString(string: text)
    Typography.AttributedString
      .style(withType: style.type, color: style.color)
      .apply(to: conversion)

    return conversion
  }
}
