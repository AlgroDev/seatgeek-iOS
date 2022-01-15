//
//  SearchEventRepositoryProtocol.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol SearchEventRepositoryProtocol {
  func retrieve(event: String, completion: @escaping (Result<[EventsListRepositoryResponseProtocol], EventRepositoryError>) -> Void)
}
