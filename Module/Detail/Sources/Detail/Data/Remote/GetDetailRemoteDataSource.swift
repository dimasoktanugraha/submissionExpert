//
//  GetDetailRemoteDataSource.swift
//  Detail
//
//  Created by Dimas Oktanugraha on 05/10/25.
//

import CorePackage
import Shared
import Combine
import Alamofire
import Foundation

public struct GetDetailRemoteDataSource: DataSource, Sendable {
  public typealias Request = Any

  public typealias Response = DetailResponse

  private let _endpoint: String

  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func execute(request: Any?) -> AnyPublisher<DetailResponse, Error> {
      guard let url = URL(string: _endpoint) else {
          return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
      }
    
      print("execute detail")

      return AF.request(url)
          .validate()
          .publishDecodable(type: DetailResponse.self)
          .value()
          .mapError { afError -> Error in
              if let urlError = afError.underlyingError as? Foundation.URLError {
                  return urlError
              } else {
                  return URLError(.cannotParseResponse)
              }
          }
          .eraseToAnyPublisher()
  }
}
