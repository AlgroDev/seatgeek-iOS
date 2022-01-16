//
//  EventNetworkItemProtocol.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol EventNetworkItemProtocol {
  var id: Int? { get }
  var title: String? { get }
  var datetimeLocal: String? { get }
  var type: String? { get }
  var venue: EventVenueItemProtocol? { get }
  var performers: [EventPerformersItemProtocol] { get }
}

protocol EventVenueItemProtocol {
  var name: String? { get }
  var city: String? { get }
  var country: String? { get }
}

protocol EventPerformersItemProtocol {
  var image: String? { get }
}

enum EventsListNetworkError: Error {
  case noInternetConnection
  case server
  case noData
  case unknown
  case parsing
}

// MARK: - EventNetworkItemProtocol

public struct EventNetworkItem: EventNetworkItemProtocol {
  var id: Int?
  var title: String?
  var datetimeLocal: String?
  var type: String?
  var venue: EventVenueItemProtocol?
  var performers: [EventPerformersItemProtocol]
}

// MARK: - EventVenueItemProtocol

public struct EventVenueItem: EventVenueItemProtocol {
  var name: String?
  var city: String?
  var country: String?
}

// MARK: - EventPerformersItemProtocol

public struct EventPerformersItem: EventPerformersItemProtocol {
  var image: String?
}
