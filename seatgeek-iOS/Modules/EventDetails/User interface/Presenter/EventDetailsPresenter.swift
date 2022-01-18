//
//  EventDetailsPresenter.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit
import SwiftUI

protocol EventDetailsPresenterDependenciesProtocol {
  var interactor: EventDetailsInteractorInput { get }
  var router: EventDetailsRouterProtocol { get }
}

final class EventDetailsPresenter: AttributedStringConvertible {

  // MARK: - Constants

  private enum Constants {
    static let title = ""
    static let dateFormat = "EEE, dd MMM dd yyyy hh:mm at"
    enum Style {
      static let title: Styles = (.body1, .black)
      static let datetimeLocal: Styles = (.body2, .gray)
      static let type: Styles = (.caption, .gray)
      static let name: Styles = (.body3Strong, .black)
      static let city: Styles = (.caption, .gray)
      static let country: Styles = (.cta, .gray)
    }
  }

  // MARK: - Properties

  weak var output: EventDetailsPresenterOutput?
  private let interactor: EventDetailsInteractorInput
  private let router: EventDetailsRouterProtocol

  // MARK: - Lifecycle

  init(dependencies: EventDetailsPresenterDependenciesProtocol) {
    interactor = dependencies.interactor
    router = dependencies.router
  }
}

// MARK: - EventDetailsPresenterInput

extension EventDetailsPresenter: EventDetailsPresenterInput {
  func viewDidLoad() {
    interactor.retrieve()
  }

  func didTapOnFavoriteBarButton() {
    interactor.addToFavorites()
  }
}

// MARK: - EventDetailsInteractorOutput

extension EventDetailsPresenter: EventDetailsInteractorOutput {
  func setDefaultValues() {
    output?.hideLoading()
  }

  func display(_ item: EventDetailsItemProtocol) {
    output?.hideLoading()
    guard let imageURL = URL(string: item.image) else { return }

    let formatter = DateFormatter()
    formatter.dateFormat = Constants.dateFormat

    let title = convertText(item.title, style: Constants.Style.title)
    let datetimeLocal = convertText(formatter.string(from: item.datetimeLocal), style: Constants.Style.datetimeLocal)
    let type = convertText(item.type, style: Constants.Style.type)
    let name = convertText(item.name, style: Constants.Style.name)
    let city = convertText(item.city, style: Constants.Style.city)
    let country = convertText(item.country, style: Constants.Style.country)
    let viewItem = EventDetailsViewItem(title: title,
                                        datetimeLocal: datetimeLocal,
                                        type: type,
                                        name: name,
                                        city: city,
                                        country: country,
                                        image: imageURL)
    output?.show(viewItem)
  }

  func item(_ isFavorite: Bool) {
    let favoriteImage = isFavorite ? Asset.favorite.image : Asset.notFavorite.image
    output?.viewItem(favoriteImage)
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

// MARK: - EventDetailsItemProtocol

private struct EventDetailsViewItem: EventDetailsViewItemProtocol {
  var title: NSAttributedString?
  var datetimeLocal: NSAttributedString?
  var type: NSAttributedString?
  var name: NSAttributedString?
  var city: NSAttributedString?
  var country: NSAttributedString?
  var image: URL
}
