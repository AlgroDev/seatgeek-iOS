//
//  SearchEventAdapterProtocol.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 15/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol SearchEventAdapterProtocol {
  func retrieve(event: String, completion: @escaping (Result<[SearchEventNetworkItemProtocol], SearchEventsListAdapterError>) -> Void)
}
