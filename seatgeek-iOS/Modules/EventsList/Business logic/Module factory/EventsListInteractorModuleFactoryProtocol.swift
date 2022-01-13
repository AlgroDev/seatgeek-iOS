//
//  EventsListInteractorModuleFactoryProtocol.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

public protocol EventsListInteractorModuleFactoryProtocol {
  var output: EventsListInteractorOutput? { get set }
  func makeResponse(from request: EventsListInteractorModuleFactoryRequestProtocol) -> EventsListInteractorModuleFactoryResponseProtocol
}

public protocol EventsListInteractorModuleFactoryRequestProtocol {}

public protocol EventsListInteractorModuleFactoryResponseProtocol {
  var interactor: EventsListInteractorInput { get }
}
