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
      guard let id = event?.id,
            let title = event?.title,
            let datetimeLocal = event?.datetimeLocal,
            let type = event?.type,
            let name = event?.venue?.name,
            let city = event?.venue?.city,
            let country = event?.venue?.country,
            let image = event?.performers.first?.image else { return }
      var isFavorite = false
      if let ids = SaveManager.get([Int].self, forKey: .favoriteEvent),
         !ids.isEmpty,
         !ids.filter({ $0 == id }).isEmpty {
        isFavorite = true
      }
      let item = EventDetailsItem(title: title,
                                  datetimeLocal: datetimeLocal,
                                  type: type,
                                  name: name,
                                  city: city,
                                  country: country,
                                  image: image,
                                  isFavorite: isFavorite)
      self?.dataSource.isFavorite = isFavorite
      self?.dataSource.id = id
      self?.output?.item(isFavorite)
      self?.output?.display(item)
    }
  }

  func addToFavorites() {
    guard var ids = SaveManager.get([Int].self, forKey: .favoriteEvent),
            !ids.isEmpty
    else {
      dataSource.isFavorite = true
      SaveManager.set([dataSource.id], forKey: .favoriteEvent)
      output?.item(dataSource.isFavorite)
      return
    }

    if ids.filter({ $0 == dataSource.id }).isEmpty {
      ids.append(dataSource.id)
      SaveManager.set(ids, forKey: .favoriteEvent)
      dataSource.isFavorite = true
    } else {
      let newIds = ids.filter { $0 != dataSource.id }
      SaveManager.set(newIds, forKey: .favoriteEvent)
      dataSource.isFavorite = false
    }
    output?.item(dataSource.isFavorite)
  }
}

// MARK: - EventDetailsItemProtocol

private struct EventDetailsItem: EventDetailsItemProtocol {
  var title: String
  var datetimeLocal: Date
  var type: String
  var name: String
  var city: String
  var country: String
  var image: String
  var isFavorite: Bool
}
