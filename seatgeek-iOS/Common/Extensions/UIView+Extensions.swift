//
//  UIView+Extensions.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

extension UIView {

  @discardableResult
  func prepareForAutoLayout() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }

  func pinToOtherView<LayoutAnchorType, Axis>(_ other: UIView,
                                              from: KeyPath<UIView, LayoutAnchorType>,
                                              to: KeyPath<UIView, LayoutAnchorType>,
                                              constant: CGFloat = 0) -> NSLayoutConstraint
  where LayoutAnchorType: NSLayoutAnchor<Axis> {
    guard superview != nil
            && ((other is UIWindow) || (other.superview != nil)) else { fatalError("must addSubview first") }

    let source = self[keyPath: from]
    let target = other[keyPath: to]
    return source.constraint(equalTo: target, constant: constant)
  }

  func pinToOtherView<LayoutAnchorType, Axis>(_ other: UIView,
                                              from: KeyPath<UIView, LayoutAnchorType>,
                                              constant: CGFloat = 0) -> NSLayoutConstraint
  where LayoutAnchorType: NSLayoutAnchor<Axis> {
    return pinToOtherView(other, from: from, to: from, constant: constant)
  }

  func pinToSuperview<LayoutAnchorType, Axis>(_ from: KeyPath<UIView, LayoutAnchorType>,
                                              to: KeyPath<UIView, LayoutAnchorType>,
                                              constant: CGFloat = 0) -> NSLayoutConstraint
  where LayoutAnchorType: NSLayoutAnchor<Axis> {
    guard let parent = superview else { fatalError("must addSubview first") }

    let source = self[keyPath: from]
    let target = parent[keyPath: to]
    return source.constraint(equalTo: target, constant: constant)
  }

  func pinToSuperview<LayoutAnchorType, Axis>(_ anchor: KeyPath<UIView, LayoutAnchorType>,
                                              constant: CGFloat = 0) -> NSLayoutConstraint
  where LayoutAnchorType: NSLayoutAnchor<Axis> {
    return pinToSuperview(anchor, to: anchor, constant: constant)
  }

  func pin(_ anchor: KeyPath<UIView, NSLayoutDimension>, constant: CGFloat) -> NSLayoutConstraint {
    return self[keyPath: anchor].constraint(equalToConstant: constant)
  }

  func pinEdgesToSuperview() -> [NSLayoutConstraint] {
    return [
      pinToSuperview(\UIView.leadingAnchor),
      pinToSuperview(\UIView.topAnchor),
      pinToSuperview(\UIView.trailingAnchor),
      pinToSuperview(\UIView.bottomAnchor)
    ]
  }

  func constraintToView(_ view: UIView) {
    leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    translatesAutoresizingMaskIntoConstraints = false
    //    layoutIfNeeded()
  }

  func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }

  @objc static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }

  static func instantiateFromNib() -> Self {

    // This method return the nib but is still typed as a UIView
    func instanceFromNib<T: UIView>() -> T {
      guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
        fatalError("Could not find nib \(self)")
      }
      return view
    }

    // Returning the result of the previous method here allow us to type the UIView as the custom view
    return instanceFromNib()
  }

  func removeSubviews() {
    for view in subviews {
      view.removeFromSuperview()
    }
  }
}



