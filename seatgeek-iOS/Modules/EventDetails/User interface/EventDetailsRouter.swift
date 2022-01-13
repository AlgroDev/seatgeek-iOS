//
//  EventDetailsRouter.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import UIKit

open class EventDetailsRouter {

  // MARK: - Property

  public weak var viewController: UIViewController?

  // MARK: - Lifecycle

  public init() { }
}

// MARK: - EventDetailsRouterProtocol

extension EventDetailsRouter: EventDetailsRouterProtocol {

}
