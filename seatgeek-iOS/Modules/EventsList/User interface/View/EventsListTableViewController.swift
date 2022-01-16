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

class EventsListViewController: UIViewController, Loadable {

  // MARK: - Outlets
  @IBOutlet private(set) weak var searchBar: UISearchBar!
  @IBOutlet private(set) weak var tableView: UITableView!


  // MARK: - Constants

  private enum Constants {
    static let eventTableViewCell = "EventTableViewCell"
  }

  // MARK: - Property

  var viewsToHideDuringLoading: [UIView] { [] }
  var activityIndicator: UIActivityIndicatorView?
  var imageLoader: ImageDownloader!
  var dependencies: EventsListViewDependenciesProtocol!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(EventTableViewCell.nib, forCellReuseIdentifier: Constants.eventTableViewCell)
    tableView.delegate = self
    tableView.dataSource = self
    searchBar.delegate = self
    self.dependencies.presenter?.viewDidLoad()
  }
}

// MARK: - UITableViewDatasource

extension EventsListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    dependencies.presenter.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dependencies.presenter.numberOfRows(at: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewItem = dependencies.presenter.viewItem(at: indexPath)

    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventTableViewCell) as?  EventTableViewCell
    else { return UITableViewCell() }

    cell.titleLabel.attributedText = viewItem?.title
    cell.titleLabel.numberOfLines = 2
    cell.dateLabel.attributedText = viewItem?.datetimeLocal
    cell.addressLabel.attributedText = viewItem?.city
    imageLoader.loadImage(imageView: cell.eventImageView, url: viewItem?.image, placeholder: UIImage(), animated: true)

    return cell
  }
}

// MARK: - UITableViewDelegate

extension EventsListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    dependencies.presenter.selectItem(at: indexPath)
  }
}

// MARK: - UISearchBarDelegate

extension EventsListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard let text = searchBar.text else { return }
    dependencies.presenter.didChangeText(input: text)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.resignFirstResponder()
    dependencies.presenter.searchBarCancelButtonClicked()
  }

  func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {

  }
}
// MARK: - EventsListPresenterOutput

extension EventsListViewController: EventsListPresenterOutput {
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
