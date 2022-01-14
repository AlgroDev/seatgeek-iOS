//
//  SelectedEventRepositoryProtocol.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

public protocol SelectedEventRepositoryProtocol:
  SelectedEventRepositoryGettable,
  SelectedEventRepositorySaveable,
  SelectedEventRepositoryClearable{}

public protocol SelectedEventRepositoryGettable {
  func get(completion: @escaping (EventsListRepositoryResponseProtocol?) -> Void)
}

public protocol SelectedEventRepositorySaveable {
  func save(_ event: EventsListRepositoryResponseProtocol)
}

public protocol SelectedEventRepositoryClearable {
  func clear(completion: ((Bool) -> Void)?)
}
