//
//  EventsListInteractor.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 3.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation
import UIKit

protocol EventsListInteractorDependenciesProtocol {
  var dataSource: EventsListInteractorDataSourceProtocol { get }
  var eventsListRepository: EventsListRepositoryProtocol { get }
  var searchEventRepository: SearchEventRepositoryProtocol { get }
  var selectedEventRepository: SelectedEventRepositoryProtocol { get }
}

final class EventsListInteractor {

  // MARK: - Constants

  private enum Constants {
    static let numberOfCategories = 1
    static let defaultMinChar = 3
  }

  // MARK: - Property

  weak var output: EventsListInteractorOutput?

  private var dataSource: EventsListInteractorDataSourceProtocol
  private var eventsListRepository: EventsListRepositoryProtocol
  private var selectedEventRepository: SelectedEventRepositoryProtocol
  private var searchEventRepository: SearchEventRepositoryProtocol
  private let mainQueue = DispatchQueue.main
  
  // MARK: - Lifecycle

  init(dependencies: EventsListInteractorDependenciesProtocol) {
    dataSource = dependencies.dataSource
    eventsListRepository = dependencies.eventsListRepository
    selectedEventRepository = dependencies.selectedEventRepository
    searchEventRepository = dependencies.searchEventRepository
  }

  deinit {}

  // MARK: - Privates

  private func notifyNetworkError() {
    mainQueue.async { [weak self] in
      self?.output?.notifyNetworkError()
    }
  }

  private func notifyServerError() {
    mainQueue.async { [weak self] in
      self?.output?.notifyServerError()
    }
  }

  private func convert(_ response: [EventsListRepositoryResponseProtocol],
                       completion: @escaping ([EventsListRepositoryResponseProtocol]) -> Void) {
    let events = response.compactMap { event -> EventsListRepositoryResponseProtocol? in
      guard let id = event.id,
            let title = event.title,
            let datetimeLocal = event.datetimeLocal,
            let type = event.type else { return nil}
      return EventsListRepositoryResponse(id: id,
                                          title: title,
                                          datetimeLocal: datetimeLocal,
                                          type: type,
                                          venue: event.venue,
                                          performers: event.performers)
    }
    dataSource.events = events
    completion(events)
  }

  private func manageEventsListRepositorySuccessResponse(_ response: [EventsListRepositoryResponseProtocol]) {
    DispatchQueue.global().async {
      self.convert(response, completion: { [weak self] events in
        if events.isEmpty {
          self?.mainQueue.async {
            self?.notifyServerError()
            return
          }
          return
        }
        self?.mainQueue.async {
          self?.output?.updateCategories()
        }
      })
    }
  }

  private func manageEventsListRepositoryFailureError(_ error: EventRepositoryError) {
    DispatchQueue.global().async { [weak self] in
      switch error {
      case .noInternetConnection: self?.notifyNetworkError()
      default: self?.notifyServerError()
      }
    }
  }
}

// MARK: - EventsListInteractorInput

extension EventsListInteractor: EventsListInteractorInput {
  func retrieve() {
    output?.setDefaultValues()
    output?.notifyLoading()
    eventsListRepository.retrieve { [weak self] result in
      switch result {
      case let .success(repositoryResponse):
        self?.manageEventsListRepositorySuccessResponse(repositoryResponse)
      case let .failure(error):
        self?.manageEventsListRepositoryFailureError(error)
      }
    }
  }

  func search(event: String) {
    if event.count < Constants.defaultMinChar {
      return
    }


  }

  func numberOfCategories() -> Int {
    return Constants.numberOfCategories
  }

  func numberOfItems(for categoryIndex: Int) -> Int {
    return dataSource.events.count
  }

  func item(atIndex index: Int, for categoryIndex: Int) -> EventsListItemProtocol? {
    let item = dataSource.events.safe[index]

    return EventsListItem(title: item?.title ?? "",
                          datetimeLocal: item?.datetimeLocal ?? "",
                          type: item?.type ?? "",
                          name: item?.venue?.name ?? "",
                          city: item?.venue?.city ?? "",
                          country: item?.venue?.country ?? "",
                          image: item?.performers.first?.image ?? "")
  }

  func selectItem(atIndex index: Int, for categoryIndex: Int) {
    guard let selectedEvent = dataSource.events.safe[index] else { return }
    selectedEventRepository.save(selectedEvent)
    output?.routeToEventsDetails()
  }
}

// MARK: - EventsListItemProtocol

private struct EventsListItem: EventsListItemProtocol {
  var title: String
  var datetimeLocal: String
  var type: String
  var name: String
  var city: String
  var country: String
  var image: String
}
