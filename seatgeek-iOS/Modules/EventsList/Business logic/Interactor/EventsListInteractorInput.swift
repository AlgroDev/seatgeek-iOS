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

public protocol EventsListInteractorInput {
  func retrieve()
  func numberOfCategories() -> Int
  func numberOfItems(for categoryIndex: Int) -> Int
  func item(atIndex index: Int, for categoryIndex: Int) -> EventsListItemProtocol?
  func selectItem(atIndex index: Int, for categoryIndex: Int)
}

public protocol EventsListItemProtocol {
  var title: String { get }
  var poster: String { get }
  var overview: String { get }
  var releaseDate: String { get }
  var voteAverage: Float? { get }
  var voteCount: Int? { get }
}
