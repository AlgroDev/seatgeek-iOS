//
//  DateFormatter+Extensions.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 16/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

extension DateFormatter {
  func posixDate(from stringDate: String?) -> Date? {
    guard let stringDate = stringDate else {
      return nil
    }
    dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    locale = Locale(identifier: "en_US_POSIX")
    return date(from: stringDate)
  }
}
