//
//  EventsListModuleFactory.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventsListModuleFactoryProtocol {
  func makeView() -> UIViewController
}

public protocol EventsListModuleFactoryDependenciesProtocol {
  var interactorFactory: EventsListInteractorModuleFactoryProtocol { get }
}

public final class EventsListModuleFactory: EventsListViewDependenciesProtocol {

  // MARK: - Properties

  var presenter: EventsListPresenterInput!

  private var interactorFactory: EventsListInteractorModuleFactoryProtocol

  // MARK: - Lifecycle

  public init(dependencies: EventsListModuleFactoryDependenciesProtocol) {
    interactorFactory = dependencies.interactorFactory
  }

  // MARK: - Private

  private func makeInteractorModuleFactoryResponse() -> EventsListInteractorModuleFactoryResponseProtocol {
    let request = EventsListInteractorModuleFactoryRequest()
    return interactorFactory.makeResponse(from: request)
  }
}

// MARK: - EventsListModuleFactoryProtocol

extension EventsListModuleFactory: EventsListModuleFactoryProtocol {
  func makeView() -> UIViewController {
    let interactorModuleFactoryResponse = makeInteractorModuleFactoryResponse()
    let router = EventsListRouter()
    let presenterDependencies = EventsListPresenterDependencies(interactor: interactorModuleFactoryResponse.interactor, router: router)
    let presenter = EventsListPresenter(dependencies: presenterDependencies)


    let viewController = StoryboardScene.EventsList.eventsListViewController.instantiate()
    viewController.dependencies = self
    interactorFactory.output = presenter
    self.presenter = presenter
    presenter.output = viewController
    router.viewController = viewController
    
    return viewController
  }
}

// MARK: - EventsListInteractorModuleFactoryRequestProtocol

private struct EventsListInteractorModuleFactoryRequest: EventsListInteractorModuleFactoryRequestProtocol {}

// MARK: - EventsListPresenterDependenciesProtocol

private struct EventsListPresenterDependencies: EventsListPresenterDependenciesProtocol {
  let interactor: EventsListInteractorInput
  let router: EventsListRouterProtocol
}
