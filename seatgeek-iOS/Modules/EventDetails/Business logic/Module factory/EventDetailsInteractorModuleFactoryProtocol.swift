//
//  EventDetailsInteractorModuleFactoryProtocol.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

public protocol EventDetailsInteractorModuleFactoryProtocol {
  var output: EventDetailsInteractorOutput? { get set }
  func makeResponse(from request: EventDetailsInteractorModuleFactoryRequestProtocol) -> EventDetailsInteractorModuleFactoryResponseProtocol
}

public protocol EventDetailsInteractorModuleFactoryRequestProtocol {}

public protocol EventDetailsInteractorModuleFactoryResponseProtocol {
  var interactor: EventDetailsInteractorInput { get }
}
