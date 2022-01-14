//
//  SelectedEventRepository.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

class SelectedEventRepository {

  // MARK: - Property

  static let shared = SelectedEventRepository()
  private var Event: EventsListRepositoryResponseProtocol?
}

// MARK: - SelectedEventRepositoryProtocol

extension SelectedEventRepository: SelectedEventRepositoryProtocol {
  func get(completion: @escaping (EventsListRepositoryResponseProtocol?) -> Void) {
    completion(Event)
  }

  func save(_ event: EventsListRepositoryResponseProtocol) {
    self.Event = event
  }

  func clear(completion: ((Bool) -> Void)?) {
    Event = nil
    completion?(true)
  }
}
