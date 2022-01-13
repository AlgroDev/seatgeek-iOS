//
//  EventsListPresenter.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventsListPresenterDependenciesProtocol {
  var interactor: EventsListInteractorInput { get }
  var router: EventsListRouterProtocol { get }
}

final class EventsListPresenter {

  // MARK: - Properties

  weak var output: EventsListPresenterOutput?
  private let interactor: EventsListInteractorInput
  private let router: EventsListRouterProtocol

  // MARK: - Lifecycle

  init(dependencies: EventsListPresenterDependenciesProtocol) {
    interactor = dependencies.interactor
    router = dependencies.router
  }

  // MARK: - Privates

}

// MARK: - EventsListPresenterInput

extension EventsListPresenter: EventsListPresenterInput {
  func viewDidLoad() {
    interactor.retrieve()
  }
}

// MARK: - EventsListInteractorOutput

extension EventsListPresenter: EventsListInteractorOutput {
  func setDefaultValues() {
  }

  func notifyLoading() {
    output?.showLoading()
  }

  func notifyNoDataError() {
    output?.hideLoading()
  }

  func notifyNetworkError() {
    output?.hideLoading()
  }

  func notifyServerError() {
    output?.hideLoading()
  }
}
