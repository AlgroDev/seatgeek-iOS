//
//  EventsListAdapterCodableResponse.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 16/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

struct EventsListAdapterCodableResponse: Codable {
  let events: [EventsListAdapterCodableResponseItem]
}

struct EventsListAdapterCodableResponseItem: Codable {
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

struct VenueCodableResponseItem: Codable {
  var name: String?
  var country: String?
  var city: String?
}

struct PerformersCodableResponseItem: Codable {
  var image: String?
}
