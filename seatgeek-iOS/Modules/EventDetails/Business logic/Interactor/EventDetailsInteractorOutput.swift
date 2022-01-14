//
//  EventDetailsInteractorOutput.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

public protocol EventDetailsInteractorOutput: AnyObject {
  func setDefaultValues()
  func notifyLoading()
  func notifyNoDataError()
  func notifyNetworkError()
  func notifyServerError()
  func display(_ item: EventDetailsItemProtocol)
}

public protocol EventDetailsItemProtocol {
  var title: String { get }
  var datetimeLocal: String { get }
  var type: String { get }
  var name: String { get }
  var city: String { get }
  var country: String { get }
  var image: String { get }
}
