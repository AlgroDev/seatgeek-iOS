//
//  EventDetailsPresenterOutput.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

enum EventDetailsViewCategory {}

protocol EventDetailsPresenterOutput: AnyObject {
  func showLoading()
  func hideLoading()
}
