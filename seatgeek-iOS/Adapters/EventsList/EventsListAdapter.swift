//
//  EventsListAdapter.swift
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

enum EventsListAdapterError: Error {
  case noInternetConnection
  case server
  case noData
  case unknown
  case parsing
}


public struct EventsListAdapterCodableResponse: Codable {
  let events: [EventsListAdapterCodableResponseItem]
}

public struct EventsListAdapterCodableResponseItem: Codable {
  var type: String?
  var id: Int?
  var datetimeLocal: String?
  var venue: VenueCodableResponseItem?
  var performers: [PerformersCodableResponseItem]?
  var title: String?

  enum CodingKeys: String, CodingKey {
    case type
    case id
    case datetimeLocal = "datetime_local"
    case venue
    case performers
    case title
  }
}

public struct VenueCodableResponseItem: Codable {
  var name: String?
  var country: String?
  var city: String?
}

public struct PerformersCodableResponseItem: Codable {
  var image: String?
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
