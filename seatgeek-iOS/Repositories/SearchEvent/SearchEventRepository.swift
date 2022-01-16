//
//  SearchEventRepository.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

class SearchEventRepository {

  // MARK: - Property

  private let apiManager: APIManagerProtocol
  private let dateFormatter: DateFormatter

  // MARK: - Lifecycle

  init(apiManager: APIManagerProtocol) {
    self.apiManager = apiManager
    self.dateFormatter = DateFormatter()
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

// MARK: - SearchEventRepositoryProtocol

extension SearchEventRepository: SearchEventRepositoryProtocol {
  func retrieve(event: String, completion: @escaping (Result<[EventsListRepositoryResponseProtocol], EventRepositoryError>) -> Void) {
    let query = event.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
    apiManager.retrieve(event: query) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(adapterResponse):
        let response = adapterResponse.map { item -> EventsListRepositoryResponseProtocol in
          let datetimeLocal = self.dateFormatter.posixDate(from: item.datetimeLocal)
          return EventsListRepositoryResponse(id: item.id,
                                               title: item.title,
                                               datetimeLocal: datetimeLocal,
                                               type: item.type,
                                               venue: EventVenueRepositoryItem(name: item.venue?.name,
                                                                               city: item.venue?.city,
                                                                               country: item.venue?.country),
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
