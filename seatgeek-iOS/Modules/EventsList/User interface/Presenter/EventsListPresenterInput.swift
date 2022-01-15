//
//  EventsListPresenterInput.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventsListPresenterInput {
  func viewDidLoad()
  func numberOfSections() -> Int
  func numberOfRows(at section: Int) -> Int
  func viewItem(at indexPath: IndexPath) -> EventsListViewItemProtocol?
  func selectItem(at indexPath: IndexPath)
  func didChangeText(input: String)
  func searchBarCancelButtonClicked()
}

public protocol EventsListViewItemProtocol {
  var title: NSAttributedString? { get }
  var datetimeLocal: NSAttributedString? { get }
  var type: NSAttributedString? { get }
  var name: NSAttributedString? { get }
  var city: NSAttributedString? { get }
  var country: NSAttributedString? { get }
  var image: URL { get }
}
