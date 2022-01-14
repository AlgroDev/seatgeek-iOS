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

protocol EventsListInteractorDependenciesProtocol {
  var dataSource: EventsListInteractorDataSourceProtocol { get }
  var eventsListRepository: EventsListRepositoryProtocol { get }
}

final class EventsListInteractor {

  // MARK: - Constants

  private enum Constants {
    static let numberOfCategories = 1
  }

  // MARK: - Property

  weak var output: EventsListInteractorOutput?

  private var dataSource: EventsListInteractorDataSourceProtocol
  private var eventsListRepository: EventsListRepositoryProtocol
  private let mainQueue = DispatchQueue.main
  
  // MARK: - Lifecycle

  init(dependencies: EventsListInteractorDependenciesProtocol) {
    dataSource = dependencies.dataSource
    eventsListRepository = dependencies.eventsListRepository
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
}

// MARK: - EventsListInteractorInput

extension EventsListInteractor: EventsListInteractorInput {
  func retrieve() {
    output?.setDefaultValues()
    output?.notifyLoading()
  }

  func numberOfCategories() -> Int {
    return Constants.numberOfCategories
  }

  func numberOfItems(for categoryIndex: Int) -> Int {
    return dataSource.events.count
  }

  func item(atIndex index: Int, for categoryIndex: Int) -> EventsListItemProtocol? {
    return nil
  }

  func selectItem(atIndex index: Int, for categoryIndex: Int) {

  }
}
