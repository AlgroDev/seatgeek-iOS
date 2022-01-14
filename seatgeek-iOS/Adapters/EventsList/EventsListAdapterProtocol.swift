//
//  EventsListRepositoryProtocol.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol EventsListAdapterProtocol {
  func retrieve(completion: @escaping (Result<[EventNetworkItemProtocol], EventsListAdapterError>) -> Void)
}
