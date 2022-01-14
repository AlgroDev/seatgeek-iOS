//
//  EventsListInteractorModuleFactory.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

public final class EventsListInteractorModuleFactory: EventsListInteractorModuleFactoryProtocol {

  // MARK: - Property

  public weak var output: EventsListInteractorOutput? {
    didSet {
      interactor?.output = output
    }
  }

  private weak var interactor: EventsListInteractor?

  // MARK: - Lifecycle

  public init() {}

  // MARK: - EventsListInteractorInput

  public func makeResponse(from request: EventsListInteractorModuleFactoryRequestProtocol) -> EventsListInteractorModuleFactoryResponseProtocol {
    let adapter = EventsListAdapter(api: NetworkAPI())
    let dependencies = EventsListInteractorDependencies(dataSource: EventsListInteractorDataSource(),
                                                        eventsListRepository: EventsListRepository(adapter: adapter))
    let interactor = EventsListInteractor(dependencies: dependencies)
    self.interactor = interactor
    let response = EventsListInteractorModuleFactoryResponse(interactor: interactor)
    return response
  }
}

// MARK: - EventsListInteractorModuleFactoryResponseProtocol

private struct EventsListInteractorModuleFactoryResponse: EventsListInteractorModuleFactoryResponseProtocol {
  let interactor: EventsListInteractorInput
}

// MARK: - EventsListInteractorDependenciesProtocol

private struct EventsListInteractorDependencies: EventsListInteractorDependenciesProtocol {
  let dataSource: EventsListInteractorDataSourceProtocol
  let eventsListRepository: EventsListRepositoryProtocol
}
