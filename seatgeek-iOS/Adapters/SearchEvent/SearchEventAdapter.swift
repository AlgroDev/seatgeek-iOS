//
//  SearchEventAdapter.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 15/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol SearchEventNetworkItemProtocol {
  var id: Int? { get }
  var title: String? { get }
  var datetimeLocal: String? { get }
  var type: String? { get }
  var venue: SearchEventVenueItemProtocol? { get }
  var performers: [SearchEventPerformersItemProtocol] { get }
}

protocol SearchEventVenueItemProtocol {
  var name: String? { get }
  var city: String? { get }
  var country: String? { get }
}

protocol SearchEventPerformersItemProtocol {
  var image: String? { get }
}

enum SearchEventsListAdapterError: Error {
  case noInternetConnection
  case server
  case noData
  case unknown
  case parsing
}
