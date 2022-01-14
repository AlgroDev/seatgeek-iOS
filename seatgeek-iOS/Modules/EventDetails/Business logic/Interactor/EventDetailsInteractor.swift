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
  var selectedEventRepository: SelectedEventRepositoryProtocol { get }
}

final class EventDetailsInteractor {

  // MARK: - Property

  weak var output: EventDetailsInteractorOutput?
  private var dataSource: EventDetailsInteractorDataSourceProtocol
  private var selectedEventRepository: SelectedEventRepositoryProtocol
  private let mainQueue = DispatchQueue.main
  
  // MARK: - Lifecycle

  init(dependencies: EventDetailsInteractorDependenciesProtocol) {
    dataSource = dependencies.dataSource
    selectedEventRepository = dependencies.selectedEventRepository
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
    selectedEventRepository.get { [weak self] event in
      guard let title = event?.title,
            let datetimeLocal = event?.datetimeLocal,
            let type = event?.type,
            let name = event?.venue?.name,
            let city = event?.venue?.city,
            let country = event?.venue?.country,
            let image = event?.performers.first?.image else { return }
      let item = EventDetailsItem(title: title,
                                  datetimeLocal: datetimeLocal,
                                  type: type,
                                  name: name,
                                  city: city,
                                  country: country,
                                  image: image)
      self?.output?.display(item)
    }
  }
}

// MARK: - EventDetailsItemProtocol

private struct EventDetailsItem: EventDetailsItemProtocol {
  var title: String
  var datetimeLocal: String
  var type: String
  var name: String
  var city: String
  var country: String
  var image: String
}
