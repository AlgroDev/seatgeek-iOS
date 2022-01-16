//
//  APIRouter.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 15/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter {
  case fetchEventsList
  case searchEvents(String)

  private enum Constant {
    static let baseURL = "https://api.seatgeek.com"
    static let version = "2"
    static let apiKey = "MjUzMzEwOTV8MTY0MjA0NTk1OS4xMDc2NzE1"
    static let apikeyString = "client_id"
  }

  var baseURL: String {
    switch self {
    case .fetchEventsList:
      return Constant.baseURL
    case .searchEvents:
      return Constant.baseURL
    }
  }

  var version: String {
    return Constant.version
  }

  var path: String {
    switch self {
    case .fetchEventsList:
      return "/\(version)/events"
    case .searchEvents(_):
      return "/\(version)/events"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .fetchEventsList, .searchEvents: return .get
    }
  }

  var parameters: [String: String]? {
    switch self {
    case .fetchEventsList:
      return [Constant.apikeyString : Constant.apiKey]
    case .searchEvents(let query):
      return ["q": query, Constant.apikeyString : Constant.apiKey]
    }
  }
}

// MARK: - URLRequestConvertible

extension APIRouter: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
    let url = try baseURL.asURL().appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.method = method
    if method == .get {
      request = try URLEncodedFormParameterEncoder()
        .encode(parameters, into: request)
    }
    return request
  }
}
