//
//  UIColor+Extensions.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 17/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

extension UIColor {
  static let typeColor = UIColor(hex: "#0d152b", alpha: 1.0)


  convenience init(hex: String, alpha: CGFloat) {
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    let alpha: CGFloat = alpha

    if hex.hasPrefix("#") {
      let index = hex.index(hex.startIndex, offsetBy: 1)
      let hex = hex.suffix(from: index)
      let scanner = Scanner(string: String(hex))
      var hexValue: CUnsignedLongLong = 0
      if scanner.scanHexInt64(&hexValue) {
        if hex.count == 6 {
          red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
          green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
          blue = CGFloat(hexValue & 0x0000FF) / 255.0
        }
      }
    }
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
