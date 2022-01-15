//
//  EventsListRepository.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

public protocol EventsListRepositoryResponseProtocol {
  var id: Int? { get }
  var title: String? { get }
  var datetimeLocal: String? { get }
  var type: String? { get }
  var venue: EventVenueRepositoryItemProtocol? { get }
  var performers: [EventPerformersRepositoryItemProtocol] { get }
}

public protocol EventVenueRepositoryItemProtocol {
  var name: String? { get }
  var city: String? { get }
  var country: String? { get }
}

public protocol EventPerformersRepositoryItemProtocol {
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

  private let apiManager: APIManagerProtocol

  // MARK: - Lifecycle

  init(apiManager: APIManagerProtocol) {
    self.apiManager = apiManager
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

  private func convert(_ performers: [EventPerformersItemProtocol]?) -> [EventPerformersRepositoryItemProtocol] {
    var result: [EventPerformersRepositoryItemProtocol] = []
    guard let performers = performers else { return result }
    for performer in performers {
      result.append(EventPerformersRepositoryItem(image: performer.image))
    }
    return result
  }
}

// MARK: - EventsListRepositoryProtocol

extension EventsListRepository: EventsListRepositoryProtocol {
  func retrieve(completion: @escaping (Result<[EventsListRepositoryResponseProtocol], EventRepositoryError>) -> Void) {
    apiManager.retrieve() { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(adapterResponse):
        let response = adapterResponse.map { item -> EventsListRepositoryResponse in
          return EventsListRepositoryResponse(id: item.id,
                                              title: item.title,
                                              datetimeLocal: item.datetimeLocal,
                                              type: item.type,
                                              venue: EventVenueRepositoryItem(name: item.venue?.name, city: item.venue?.city, country: item.venue?.country),
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

struct EventsListRepositoryResponse: EventsListRepositoryResponseProtocol {
  var id: Int?
  var title: String?
  var datetimeLocal: String?
  var type: String?
  var venue: EventVenueRepositoryItemProtocol?
  var performers: [EventPerformersRepositoryItemProtocol]
}

// MARK: - EventVenueRepositoryItemProtocol

struct EventVenueRepositoryItem: EventVenueRepositoryItemProtocol {
  var name: String?
  var city: String?
  var country: String?
}

// MARK: - EventPerformersRepositoryItemProtocol

struct EventPerformersRepositoryItem: EventPerformersRepositoryItemProtocol {
  var image: String?
}
