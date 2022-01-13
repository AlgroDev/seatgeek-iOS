//
//  EventDetailsViewController.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventDetailsViewDependenciesProtocol {
  var presenter: EventDetailsPresenterInput! { get }
}

class EventDetailsViewController: UIViewController, Loadable {

  // MARK: - Outlet

  // MARK: - Property

  var viewsToHideDuringLoading: [UIView] { view.subviews }
  var activityIndicator: UIActivityIndicatorView?
  var dependencies: EventDetailsViewDependenciesProtocol!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.dependencies.presenter?.viewDidLoad()
  }
}

// MARK: - EventDetailsPresenterOutput

extension EventDetailsViewController: EventDetailsPresenterOutput {
  func showLoading() {
    startLoading()
  }

  func hideLoading() {
    stopLoading()
  }
}
