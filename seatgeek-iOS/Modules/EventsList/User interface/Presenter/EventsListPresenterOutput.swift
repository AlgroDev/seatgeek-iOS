//
//  EventsListPresenterOutput.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventsListPresenterOutput: AnyObject {
  func showLoading()
  func hideLoading()
  func reloadData()
  func showErrorMessage(_ title: NSAttributedString, message: NSAttributedString)
}
