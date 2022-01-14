//
//  EventsListRepositoryProtocol.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol EventsListRepositoryProtocol: AnyObject {
  func retrieve(completion: @escaping (Result<[EventsListRepositoryResponseProtocol], EventRepositoryError>) -> Void)
}
