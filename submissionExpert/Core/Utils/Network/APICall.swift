//
//  APICall.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation

struct API {

  static let baseUrl = "https://api.rawg.io/api/"
  static let apiKey = APIConfig.apiKey

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {

  enum Gets: Endpoint {
    case games(query: String)
    case detail(id: Int)

    public var url: String {
      switch self {
      case .games(let query): return "\(API.baseUrl)games?key=\(API.apiKey)&search=\(query)"
      case .detail(let id): return "\(API.baseUrl)games/\(id)?key=\(API.apiKey)"
      }
    }
  }

}
