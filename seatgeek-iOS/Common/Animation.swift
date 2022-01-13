//
//  Animation.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

public typealias VoidFunction = (() -> Void)
private let duration = 0.3

public func animate(_ animations: @escaping VoidFunction) {
  UIView.animate(withDuration: duration, animations: animations)
}

public func animate(animations: @escaping VoidFunction, completion: @escaping VoidFunction) {
  UIView.animate(withDuration: duration, animations: animations, completion: { _ in completion() })
}

