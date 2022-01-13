//
//  EventsListRouter.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

open class EventsListRouter {

  // MARK: - Property

  public weak var viewController: UIViewController?

  // MARK: - Lifecycle

  public init() { }
}

// MARK: - EventsListRouterProtocol

extension EventsListRouter: EventsListRouterProtocol {
  public func routeToEventsDetails() {
    let dependencies = EventDetailsModuleFactoryDependencies(interactorFactory: EventDetailsInteractorModuleFactory())
    let eventDetailsViewController = EventDetailsModuleFactory(dependencies: dependencies).makeView()
    eventDetailsViewController.modalPresentationStyle = .fullScreen
    viewController?.navigationController?.show(eventDetailsViewController, sender: nil)
  }
}

// MARK: - EventDetailsModuleFactoryDependenciesProtocol

private struct EventDetailsModuleFactoryDependencies: EventDetailsModuleFactoryDependenciesProtocol {
  var interactorFactory: EventDetailsInteractorModuleFactoryProtocol
}
