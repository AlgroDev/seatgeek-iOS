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

final class EventsListPresenter: AttributedStringConvertible {

  // MARK: - Constants

  private enum Constants {
    static let title = ""

    enum Style {
      static let title: Styles = (.errorDescription, .black)
      static let datetimeLocal: Styles = (.errorDescription, .black)
      static let type: Styles = (.errorDescription, .black)
      static let name: Styles = (.errorDescription, .black)
      static let city: Styles = (.errorDescription, .black)
      static let country: Styles = (.errorDescription, .black)
    }
  }

  // MARK: - Properties

  weak var output: EventsListPresenterOutput?
  private let interactor: EventsListInteractorInput
  private let router: EventsListRouterProtocol

  // MARK: - Lifecycle

  init(dependencies: EventsListPresenterDependenciesProtocol) {
    interactor = dependencies.interactor
    router = dependencies.router
  }
}

// MARK: - EventsListPresenterInput

extension EventsListPresenter: EventsListPresenterInput {
  func viewDidLoad() {
    interactor.retrieve()
  }

  func numberOfSections() -> Int {
    interactor.numberOfCategories()
  }

  func numberOfRows(at section: Int) -> Int {
    interactor.numberOfItems(for: section)
  }

  func viewItem(at indexPath: IndexPath) -> EventsListViewItemProtocol? {
    output?.hideLoading()
    guard let viewItem = interactor.item(atIndex: indexPath.row, for: indexPath.section) else { return nil }
    let title = convertText(viewItem.title, style: Constants.Style.title)
    let datetimeLocal = convertText(viewItem.datetimeLocal, style: Constants.Style.datetimeLocal)
    let type = convertText(viewItem.type, style: Constants.Style.type)
    let name = convertText(viewItem.name, style: Constants.Style.name)
    let city = convertText(viewItem.city, style: Constants.Style.city)
    let country = convertText(viewItem.country, style: Constants.Style.country)
    guard let image = URL(string: viewItem.image) else { return nil }
    return EventsListViewItem(title: title,
                              datetimeLocal: datetimeLocal,
                              type: type,
                              name: name,
                              city: city,
                              country: country,
                              image: image)
  }

  func selectItem(at indexPath: IndexPath) {
    interactor.selectItem(atIndex: indexPath.row, for: indexPath.section)
  }

  func didChangeText(input: String) {
    interactor.search(event: input)
  }
}

// MARK: - EventsListInteractorOutput

extension EventsListPresenter: EventsListInteractorOutput {
  func setDefaultValues() {
    output?.hideLoading()
  }

  func updateCategories() {
    output?.reloadData()
  }

  func routeToEventsDetails() {
    router.routeToEventsDetails()
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

// MARK: - EventsListViewItemProtocol

private struct EventsListViewItem: EventsListViewItemProtocol {
  var title: NSAttributedString?
  var datetimeLocal: NSAttributedString?
  var type: NSAttributedString?
  var name: NSAttributedString?
  var city: NSAttributedString?
  var country: NSAttributedString?
  var image: URL
}
