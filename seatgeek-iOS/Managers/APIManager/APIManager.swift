//
//  APIManager.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 15/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
  static let shared = APIManager()

  let sessionManager: Session = {
    let configuration = URLSessionConfiguration.af.default
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    let responseCacher = ResponseCacher(behavior: .modify { _, response in
      let userInfo = ["date": Date()]
      return CachedURLResponse(response: response.response,
                               data: response.data,
                               userInfo: userInfo,
                               storagePolicy: .allowed)})
    let networkLogger = NetworkLogger()

    return Session(configuration: configuration,
                   cachedResponseHandler: responseCacher,
                   eventMonitors: [networkLogger])
  }()

  // MARK: - Conversion

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

extension APIManager: APIManagerProtocol {
  func retrieve(completion: @escaping (Result<[EventNetworkItemProtocol], EventsListNetworkError>) -> Void) {
    sessionManager.request(APIRouter.fetchEventsList)
      .responseDecodable(of: EventsListCodableResponse.self) { response in
        guard let repositories = response.value else {
          return completion(.failure(.server))
        }
        if repositories.events.isEmpty {
          return completion(.failure(.noData))
        }
        let events = repositories.events.map { event in
          return EventNetworkItem(id: event.id,
                                  title: event.title,
                                  datetimeLocal: event.datetimeLocal,
                                  type: event.type,
                                  venue: EventVenueItem(name: event.venue?.name, city: event.venue?.city, country: event.venue?.country),
                                  performers: self.convert(event.performers))
        }
        completion(.success(events))
      }
  }

  func retrieve(event: String, completion: @escaping (Result<[EventNetworkItemProtocol], EventsListNetworkError>) -> Void) {
    sessionManager.request(APIRouter.searchEvents(event))
      .responseDecodable(of: EventsListCodableResponse.self) { response in
        guard let repositories = response.value else {
          return completion(.failure(.server))
        }
        if repositories.events.isEmpty {
          return completion(.failure(.noData))
        }
        let events = repositories.events.map { event in
          return EventNetworkItem(id: event.id,
                                  title: event.title,
                                  datetimeLocal: event.datetimeLocal,
                                  type: event.type,
                                  venue: EventVenueItem(name: event.venue?.name, city: event.venue?.city, country: event.venue?.country),
                                  performers: self.convert(event.performers))
        }
        completion(.success(events))
      }
  }
}
