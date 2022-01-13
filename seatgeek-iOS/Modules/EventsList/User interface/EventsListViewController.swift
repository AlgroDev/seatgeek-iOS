//
//  EventsListViewController.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventsListViewDependenciesProtocol {
  var presenter: EventsListPresenterInput! { get }
}

class EventsListViewController: UIViewController, Loadable {

  // MARK: - Outlet

  // MARK: - Property

  var viewsToHideDuringLoading: [UIView] { view.subviews }
  var activityIndicator: UIActivityIndicatorView?
  var dependencies: EventsListViewDependenciesProtocol!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.dependencies.presenter?.viewDidLoad()
  }
}

// MARK: - EventsListPresenterOutput

extension EventsListViewController: EventsListPresenterOutput {
  func showLoading() {
    startLoading()
  }

  func hideLoading() {
    stopLoading()
  }
}
