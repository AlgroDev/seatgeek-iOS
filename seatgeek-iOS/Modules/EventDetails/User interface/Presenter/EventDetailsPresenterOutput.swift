//
//  EventDetailsPresenterOutput.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventDetailsPresenterOutput: AnyObject {
  func showLoading()
  func hideLoading()
  func show(_ viewItem: EventDetailsViewItemProtocol)
  func viewItem(_ favoriteImage: UIImage)
}

public protocol EventDetailsViewItemProtocol {
  var title: NSAttributedString? { get }
  var datetimeLocal: NSAttributedString? { get }
  var type: NSAttributedString? { get }
  var name: NSAttributedString? { get }
  var city: NSAttributedString? { get }
  var country: NSAttributedString? { get }
  var image: URL { get }
}
