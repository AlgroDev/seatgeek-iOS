//
//  EventsListRepository.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol EventsListRepositoryResponseProtocol {
  var id: Int? { get }
  var title: String? { get }
  var datetimeLocal: String? { get }
  var type: String? { get }
  var venue: [EventVenueRepositoryItemProtocol] { get }
  var performers: [EventPerformersRepositoryItemProtocol] { get }
}

protocol EventVenueRepositoryItemProtocol {
  var name: String? { get }
  var city: String? { get }
  var country: String? { get }
}

protocol EventPerformersRepositoryItemProtocol {
  var image: String? { get }
}

enum EventRepositoryError: Error {
  case noInternetConnection
  case server
  case noData
  case unowned
}

class EventsListRepository {

  // MARK: - Property

  private let adapter: EventsListAdapterProtocol

  // MARK: - Lifecycle

  init(adapter: EventsListAdapterProtocol) {
    self.adapter = adapter
  }

  // MARK: - Conversion

  private func convertToEventsListRepositoryError(_ adapterError: EventsListAdapterError) -> EventRepositoryError {
    switch adapterError {
    case .noInternetConnection:
      return .noInternetConnection
    case .server:
      return .server
    case .noData:
      return .noData
    default:
      return .unowned
    }
  }

  private func convert(_ venues: [EventVenueItemProtocol]?) -> [EventVenueRepositoryItemProtocol] {
    var result: [EventVenueRepositoryItemProtocol] = []
    guard let venues = venues else { return result }
    for venue in venues {
      result.append(EventVenueRepositoryItem(name: venue.name,
                                             city: venue.city,
                                             country: venue.country))
    }
    return result
  }

  private func convert(_ performers: [EventPerformersItemProtocol]?) -> [EventPerformersRepositoryItemProtocol] {
    var result: [EventPerformersRepositoryItemProtocol] = []
    guard let performers = performers else { return result }
    for performer in performers {
      result.append(EventPerformersRepositoryItem(image: performer.image))
    }
    return result
  }
}

extension EventsListRepository: EventsListRepositoryProtocol {
  func retrieve(completion: @escaping (Result<[EventsListRepositoryResponseProtocol], EventRepositoryError>) -> Void) {
    adapter.retrieve() { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(adapterResponse):
        let response = adapterResponse.map { item -> EventsListRepositoryResponse in
          return EventsListRepositoryResponse(id: item.id,
                                              title: item.title,
                                              datetimeLocal: item.datetimeLocal,
                                              type: item.type,
                                              venue: self.convert(item.venue),
                                              performers: self.convert(item.performers))
        }
        completion(.success(response))
      case let .failure(wrapperError):
        let error = self.convertToEventsListRepositoryError(wrapperError)
        completion(.failure(error))
      }
    }
  }
}

// MARK: - EventsListRepositoryResponseProtocol

private struct EventsListRepositoryResponse: EventsListRepositoryResponseProtocol {
  var id: Int?
  var title: String?
  var datetimeLocal: String?
  var type: String?
  var venue: [EventVenueRepositoryItemProtocol]
  var performers: [EventPerformersRepositoryItemProtocol]
}

// MARK: - EventVenueRepositoryItemProtocol

private struct EventVenueRepositoryItem: EventVenueRepositoryItemProtocol {
  var name: String?
  var city: String?
  var country: String?
}

// MARK: - EventPerformersRepositoryItemProtocol

private struct EventPerformersRepositoryItem: EventPerformersRepositoryItemProtocol {
  var image: String?
}
