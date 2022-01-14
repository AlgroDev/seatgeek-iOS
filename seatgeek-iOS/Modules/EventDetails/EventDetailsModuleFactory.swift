//
//  EventDetailsModuleFactory.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventDetailsModuleFactoryProtocol {
  func makeView() -> UIViewController
}

public protocol EventDetailsModuleFactoryDependenciesProtocol {
  var interactorFactory: EventDetailsInteractorModuleFactoryProtocol { get }
}

public final class EventDetailsModuleFactory: EventDetailsViewDependenciesProtocol {

  // MARK: - Properties

  var presenter: EventDetailsPresenterInput!

  private var interactorFactory: EventDetailsInteractorModuleFactoryProtocol

  // MARK: - Lifecycle

  public init(dependencies: EventDetailsModuleFactoryDependenciesProtocol) {
    interactorFactory = dependencies.interactorFactory
  }

  // MARK: - Private

  private func makeInteractorModuleFactoryResponse() -> EventDetailsInteractorModuleFactoryResponseProtocol {
    let request = EventDetailsInteractorModuleFactoryRequest()
    return interactorFactory.makeResponse(from: request)
  }
}

// MARK: - EventDetailsModuleFactoryProtocol

extension EventDetailsModuleFactory: EventDetailsModuleFactoryProtocol {
  func makeView() -> UIViewController {
    let interactorModuleFactoryResponse = makeInteractorModuleFactoryResponse()
    let router = EventDetailsRouter()
    let presenterDependencies = EventDetailsPresenterDependencies(interactor: interactorModuleFactoryResponse.interactor, router: router)
    let presenter = EventDetailsPresenter(dependencies: presenterDependencies)

    let viewController = StoryboardScene.EventDetails.eventDetailsViewController.instantiate()
    viewController.dependencies = self
    viewController.imageLoader = DesignSystemImageDownloader()
    interactorFactory.output = presenter
    self.presenter = presenter
    presenter.output = viewController
    router.viewController = viewController
    
    return viewController
  }
}

// MARK: - EventDetailsInteractorModuleFactoryRequestProtocol

private struct EventDetailsInteractorModuleFactoryRequest: EventDetailsInteractorModuleFactoryRequestProtocol {}

// MARK: - EventDetailsPresenterDependenciesProtocol

private struct EventDetailsPresenterDependencies: EventDetailsPresenterDependenciesProtocol {
  let interactor: EventDetailsInteractorInput
  let router: EventDetailsRouterProtocol
}
