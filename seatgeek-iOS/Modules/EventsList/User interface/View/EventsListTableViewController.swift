//
//  EventsListTableViewController.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

protocol EventsListViewDependenciesProtocol {
  var presenter: EventsListPresenterInput! { get }
}

class EventsListTableViewController: UITableViewController, Loadable {

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

extension EventsListTableViewController: EventsListPresenterOutput {
  func reloadData() {

  }

  func showErrorMessage(_ title: NSAttributedString, message: NSAttributedString) {
    
  }

  func showLoading() {
    startLoading()
  }

  func hideLoading() {
    stopLoading()
  }
}
