//
//  Loadable.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation
import UIKit

public protocol Loadable: AnyObject {

  var viewsToHideDuringLoading: [UIView] { get }
  var activityIndicator: UIActivityIndicatorView? { get set }

  func startLoading()
  func startLoading(animated: Bool)
  func stopLoading()
}

public extension Loadable {

  func startLoading() {
    startLoading(animated: true)
  }

  func stopLoading() {
    activityIndicator?.stopAnimating()
    for viewToHideDuringLoading in viewsToHideDuringLoading {
      viewToHideDuringLoading.alpha = 0
      animate(animations: {
        viewToHideDuringLoading.alpha = 1
      }, completion: {
        self.activityIndicator?.removeFromSuperview()
      })
    }
  }

  private func startLoading(on view: UIView, animated: Bool) {
    guard self.activityIndicator?.superview == nil else {
      return
    }
    for viewToHideDuringLoading in viewsToHideDuringLoading {
      viewToHideDuringLoading.alpha = 1
      if animated {
        animate { viewToHideDuringLoading.alpha = 0 }
      } else {
        viewToHideDuringLoading.alpha = 0
      }
    }

    let activityIndicator = UIActivityIndicatorView(style: .large).prepareForAutoLayout()
    activityIndicator.color = .blue
    view.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.pinToSuperview(\UIView.centerXAnchor),
      activityIndicator.pinToSuperview(\UIView.centerYAnchor)
    ])
    activityIndicator.startAnimating()
    view.layoutIfNeeded()
    self.activityIndicator = activityIndicator
  }
}

public extension Loadable where Self: UIViewController {

  func startLoading(animated: Bool) {
    startLoading(on: view, animated: animated)
  }
}

public extension Loadable where Self: UIView {

  func startLoading(animated: Bool) {
    startLoading(on: self, animated: animated)
  }
}

