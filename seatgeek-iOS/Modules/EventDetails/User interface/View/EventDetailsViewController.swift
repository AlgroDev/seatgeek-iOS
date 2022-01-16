//
//  EventDetailsViewController.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit
import SwiftUI

protocol EventDetailsViewDependenciesProtocol {
  var presenter: EventDetailsPresenterInput! { get }
}

class EventDetailsViewController: UIViewController, Loadable {
  
  // MARK: - Outlet
  
  @IBOutlet private(set) weak var dateLabel: UILabel!
  @IBOutlet private(set) weak var addressLabel: UILabel!
  @IBOutlet private(set) weak var eventImageView: UIImageView! {
    didSet {
      eventImageView.layer.cornerRadius = 10
      eventImageView.layer.masksToBounds = true
    }
  }

  // MARK: - Property
  
  var viewsToHideDuringLoading: [UIView] { view.subviews }
  var activityIndicator: UIActivityIndicatorView?
  var imageLoader: ImageDownloader!
  var dependencies: EventDetailsViewDependenciesProtocol!
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRightBarButton()
    self.dependencies.presenter?.viewDidLoad()
  }

  @IBAction func favoriteBarItem(_ sender: Bool) {
    if ((navigationItem.leftBarButtonItem?.isSelected) != nil) {
      navigationItem.leftBarButtonItem?.image = Asset.favorite.image
      return
    }
    navigationItem.leftBarButtonItem?.image = Asset.notFavorite.image
  }

  private func setupRightBarButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.notFavorite.image,
                                                       landscapeImagePhone: Asset.notFavorite.image,
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(didTapOnRightBarButton))
    navigationItem.rightBarButtonItem?.tintColor = .systemRed
  }

  @objc private func didTapOnRightBarButton() {
    navigationItem.rightBarButtonItem?.image = Asset.favorite.image
  }
}

// MARK: - EventDetailsPresenterOutput

extension EventDetailsViewController: EventDetailsPresenterOutput {
  func show(_ viewItem: EventDetailsViewItemProtocol) {
    imageLoader.loadImage(imageView: eventImageView, url: viewItem.image, placeholder: UIImage(), animated: true)
    dateLabel.attributedText = viewItem.datetimeLocal
    addressLabel.attributedText = viewItem.city
    
    let label = UILabel()
    label.text = viewItem.title?.string
    label.numberOfLines = 2
    label.textAlignment = .center
    self.navigationItem.titleView = label
  }
  
  func showLoading() {
    startLoading()
  }
  
  func hideLoading() {
    stopLoading()
  }
}
