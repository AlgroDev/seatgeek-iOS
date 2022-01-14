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

  // MARK: - Outlets
  @IBOutlet weak var searchBar: UISearchBar!


  // MARK: - Constants

  private enum Constants {
    static let eventTableViewCell = "EventTableViewCell"
  }

  // MARK: - Property

  var viewsToHideDuringLoading: [UIView] { [searchBar] }
  var activityIndicator: UIActivityIndicatorView?
  var imageLoader: ImageDownloader!
  var dependencies: EventsListViewDependenciesProtocol!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(EventTableViewCell.nib, forCellReuseIdentifier: Constants.eventTableViewCell)
    searchBar.delegate = self
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
    cell.addressLabel.attributedText = viewItem?.city
    imageLoader.loadImage(imageView: cell.eventImageView, url: viewItem?.image, placeholder: UIImage(), animated: true)

    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    dependencies.presenter.selectItem(at: indexPath)
  }
}

// MARK: - UISearchBarDelegate

extension EventsListTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

  }
}
// MARK: - EventsListPresenterOutput

extension EventsListTableViewController: EventsListPresenterOutput {
  func reloadData() {
    hideLoading()
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
