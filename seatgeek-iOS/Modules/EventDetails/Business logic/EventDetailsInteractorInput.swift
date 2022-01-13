//
//  EventDetailsInteractorInput.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

public enum EventDetailsCategory {
}

extension EventDetailsCategory: Equatable {
  public static func == (lhs: EventDetailsCategory,
                         rhs: EventDetailsCategory) -> Bool {
    switch (lhs, rhs) {
    default:
      return false
    }
  }
}

public protocol EventDetailsInteractorInput {
  func retrieve()
}
