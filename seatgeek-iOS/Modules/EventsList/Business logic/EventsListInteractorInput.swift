//
//  EventsListInteractorInput.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

public enum EventsListCategory {
}

extension EventsListCategory: Equatable {
  public static func == (lhs: EventsListCategory,
                         rhs: EventsListCategory) -> Bool {
    switch (lhs, rhs) {
    default:
      return false
    }
  }
}

public protocol EventsListInteractorInput {
  func retrieve()
}
