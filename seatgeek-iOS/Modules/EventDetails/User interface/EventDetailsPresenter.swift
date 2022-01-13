//
//  EventDetailsPresenter.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventDetailsPresenterDependenciesProtocol {
  var interactor: EventDetailsInteractorInput { get }
  var router: EventDetailsRouterProtocol { get }
}

final class EventDetailsPresenter {

  // MARK: - Properties

  weak var output: EventDetailsPresenterOutput?
  private let interactor: EventDetailsInteractorInput
  private let router: EventDetailsRouterProtocol

  // MARK: - Lifecycle

  init(dependencies: EventDetailsPresenterDependenciesProtocol) {
    interactor = dependencies.interactor
    router = dependencies.router
  }

  // MARK: - Privates

}

// MARK: - EventDetailsPresenterInput

extension EventDetailsPresenter: EventDetailsPresenterInput {
  func viewDidLoad() {
    interactor.retrieve()
  }
}

// MARK: - EventDetailsInteractorOutput

extension EventDetailsPresenter: EventDetailsInteractorOutput {
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
