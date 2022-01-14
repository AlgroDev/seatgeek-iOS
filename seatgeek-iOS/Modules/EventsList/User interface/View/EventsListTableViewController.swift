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

  // MARK: - Constants

  private enum Constants {
    static let eventTableViewCell = "EventTableViewCell"
  }

  // MARK: - Property

  var viewsToHideDuringLoading: [UIView] { view.subviews }
  var activityIndicator: UIActivityIndicatorView?
  var dependencies: EventsListViewDependenciesProtocol!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(EventTableViewCell.nib, forCellReuseIdentifier: Constants.eventTableViewCell)
    self.dependencies.presenter?.viewDidLoad()
  }


  // MARK: - UITableViewDatasource

  override func numberOfSections(in tableView: UITableView) -> Int {
    dependencies.presenter.numberOfSections()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dependencies.presenter.numberOfRows(at: section)
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewItem = dependencies.presenter.viewItem(at: indexPath)

    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventTableViewCell) as?  EventTableViewCell
    else { return UITableViewCell() }

    cell.titleLabel.attributedText = viewItem?.title
    cell.dateLabel.attributedText = viewItem?.datetimeLocal

    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    dependencies.presenter.selectItem(at: indexPath)
  }
}

// MARK: - EventsListPresenterOutput

extension EventsListTableViewController: EventsListPresenterOutput {
  func reloadData() {
    tableView.reloadData()
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
