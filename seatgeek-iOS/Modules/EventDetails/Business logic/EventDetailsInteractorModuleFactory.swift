//
//  EventDetailsInteractorModuleFactory.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

public final class EventDetailsInteractorModuleFactory: EventDetailsInteractorModuleFactoryProtocol {

  // MARK: - Property

  public weak var output: EventDetailsInteractorOutput? {
    didSet {
      interactor?.output = output
    }
  }

  private weak var interactor: EventDetailsInteractor?

  // MARK: - Lifecycle

  public init() {}

  // MARK: - EventDetailsInteractorInput

  public func makeResponse(from request: EventDetailsInteractorModuleFactoryRequestProtocol) -> EventDetailsInteractorModuleFactoryResponseProtocol {
    let dependencies = EventDetailsInteractorDependencies(dataSource: EventDetailsInteractorDataSource())
    let interactor = EventDetailsInteractor(dependencies: dependencies)
    self.interactor = interactor
    let response = EventDetailsInteractorModuleFactoryResponse(interactor: interactor)
    return response
  }
}

// MARK: - EventDetailsInteractorModuleFactoryResponseProtocol

private struct EventDetailsInteractorModuleFactoryResponse: EventDetailsInteractorModuleFactoryResponseProtocol {
  let interactor: EventDetailsInteractorInput
}

// MARK: - EventDetailsInteractorDependenciesProtocol

private struct EventDetailsInteractorDependencies: EventDetailsInteractorDependenciesProtocol {
  let dataSource: EventDetailsInteractorDataSourceProtocol
}
