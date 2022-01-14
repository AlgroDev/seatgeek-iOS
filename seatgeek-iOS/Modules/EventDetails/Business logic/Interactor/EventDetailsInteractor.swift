//
//  EventDetailsInteractor.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 3.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

protocol EventDetailsInteractorDependenciesProtocol {
  var dataSource: EventDetailsInteractorDataSourceProtocol { get }
}

final class EventDetailsInteractor {

  // MARK: - Property

  weak var output: EventDetailsInteractorOutput?
  private let orderedCategories: [EventDetailsCategory] = [
  ]

  private var dataSource: EventDetailsInteractorDataSourceProtocol
  private let mainQueue = DispatchQueue.main
  
  // MARK: - Lifecycle

  init(dependencies: EventDetailsInteractorDependenciesProtocol) {
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

// MARK: - EventDetailsInteractorInput

extension EventDetailsInteractor: EventDetailsInteractorInput {
  func retrieve() {
    output?.setDefaultValues()
    output?.notifyLoading()
  }
}
