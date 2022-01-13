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
}

final class EventsListInteractor {

  // MARK: - Property

  weak var output: EventsListInteractorOutput?
  private let orderedCategories: [EventsListCategory] = [
  ]

  private var dataSource: EventsListInteractorDataSourceProtocol
  private let mainQueue = DispatchQueue.main
  
  // MARK: - Lifecycle

  init(dependencies: EventsListInteractorDependenciesProtocol) {
    dataSource = dependencies.dataSource
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
}
