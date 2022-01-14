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

  @IBOutlet private(set) weak var dateLabel: UILabel!
  @IBOutlet private(set) weak var addressLabel: UILabel!
  @IBOutlet private(set) weak var eventImageView: UIImageView!


  // MARK: - Property

  var viewsToHideDuringLoading: [UIView] { view.subviews }
  var activityIndicator: UIActivityIndicatorView?
  var imageLoader: ImageDownloader!
  var dependencies: EventDetailsViewDependenciesProtocol!

  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
//    navigationController?.navigationBar.prefersLargeTitles = true
//    navigationItem.largeTitleDisplayMode = .always
    self.dependencies.presenter?.viewDidLoad()
  }
}

// MARK: - EventDetailsPresenterOutput

extension EventDetailsViewController: EventDetailsPresenterOutput {
  func show(_ viewItem: EventDetailsViewItemProtocol) {
    hideLoading()
    imageLoader.loadImage(imageView: eventImageView, url: viewItem.image, placeholder: UIImage(), animated: true)
//    title = viewItem.title?.string
    dateLabel.attributedText = viewItem.datetimeLocal
    addressLabel.attributedText = viewItem.city

    let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.text = viewItem.title?.string //"FIFA" + " \n " + "Europe 2018-2019"
        self.navigationItem.titleView = label
  }

  func showLoading() {
    startLoading()
  }

  func hideLoading() {
    stopLoading()
  }
}
