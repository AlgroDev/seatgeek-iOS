//
//  EventsListInteractorDataSourceProtocol.swift
//  seatgeek-iOS
//
//  Mobissiweb template version 1.0
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 seatgeek-iOS. All rights reserved.
//

import Foundation

protocol EventsListInteractorDataSourceProtocol {
  var events: [EventsListRepositoryResponseProtocol] { get set }
  var curents: [EventsListRepositoryResponseProtocol] { get set }
  var searchEvents: [EventsListRepositoryResponseProtocol] { get set }
}
