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


class EventsListAdapter {

  // MARK: - Constants

  private enum Constants {
    static let baseURL = "https://api.seatgeek.com"
    static let version = "2"
    static let path = "events"
    static let eventsURL = "\(baseURL)/\(version)/\(path)?\(apikeyString)=\(apiKey)"
    static let apiKey = "MjUzMzEwOTV8MTY0MjA0NTk1OS4xMDc2NzE1"
    static let apikeyString = "client_id"
  }

  // MARK: - Property

  private let api: NetworkAPI

  // MARK: - Lifecycle

  init(api: NetworkAPI) {
    self.api = api
  }

  // MARK: - Conversion

  private func convert(_ error: NetworkAPIError) -> EventsListAdapterError? {
    switch error {
    case .network: return .noInternetConnection
    case .server: return .server
    case .noData: return .noData
    case .unknown: return .unknown
    }
  }

  private func convert(_ performers: [PerformersCodableResponseItem]?) -> [EventPerformersItemProtocol] {
    var result: [EventPerformersItemProtocol] = []
    guard let performers = performers else { return result }
    for performer in performers {
      result.append(EventPerformersItem(image: performer.image))
    }
    return result
  }
}

// MARK: - EventsListAdapterProtocol

extension EventsListAdapter: EventsListAdapterProtocol {
  func retrieve(completion: @escaping (Result<[EventNetworkItemProtocol], EventsListAdapterError>) -> Void) {
    api.request(urlString: Constants.eventsURL,
                method: .get,
                parameters: [:],
                success: { data in
      DispatchQueue.global().async {
        do {
          let responseCondable = try JSONDecoder().decode(EventsListAdapterCodableResponse.self, from: data)
          let events = responseCondable.events.map { event in
            return EventNetworkItem(id: event.id,
                                    title: event.title,
                                    datetimeLocal: event.datetimeLocal,
                                    type: event.type,
                                    venue: EventVenueItem(name: event.venue?.name, city: event.venue?.city, country: event.venue?.country),
                                    performers: self.convert(event.performers))
          }
          DispatchQueue.main.async {
            if events.isEmpty {
              completion(.failure(.noData))
            } else {
              completion(.success(events))
            }
          }
        } catch {
          DispatchQueue.main.async {
            completion(.failure(.parsing))
          }
        }
      }
    }, failure: { [weak self] error in
      DispatchQueue.main.async {
        guard let errorConverted = self?.convert(error) else { return }
        completion(.failure(errorConverted))
      }
    })
  }
}

private struct EventsListAdapterCodableResponse: Codable {
  let events: [EventsListAdapterCodableResponseItem]
}

private struct EventsListAdapterCodableResponseItem: Codable {
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

private struct VenueCodableResponseItem: Codable {
  var name: String?
  var country: String?
  var city: String?
}

private struct PerformersCodableResponseItem: Codable {
  var image: String?
}

// MARK: - EventNetworkItemProtocol

private struct EventNetworkItem: EventNetworkItemProtocol {
  var id: Int?
  var title: String?
  var datetimeLocal: String?
  var type: String?
  var venue: EventVenueItemProtocol?
  var performers: [EventPerformersItemProtocol]
}

// MARK: - EventVenueItemProtocol

private struct EventVenueItem: EventVenueItemProtocol {
  var name: String?
  var city: String?
  var country: String?
}

// MARK: - EventPerformersItemProtocol

private struct EventPerformersItem: EventPerformersItemProtocol {
  var image: String?
}
