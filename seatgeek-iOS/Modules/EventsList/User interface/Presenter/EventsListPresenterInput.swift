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
}

public protocol EventsListViewItemProtocol {
  var title: NSAttributedString { get }
  var poster: URL { get }
  var overview: NSAttributedString { get }
  var releaseDate: NSAttributedString { get }
  var voteAverage: NSAttributedString? { get }
  var voteCount: NSAttributedString? { get }
}
