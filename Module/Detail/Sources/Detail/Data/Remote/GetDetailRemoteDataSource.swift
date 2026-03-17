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
//            completion(.failure(URLError.invalidResponse))
          }
          .eraseToAnyPublisher()
  }
    
//  public func execute(request: Any?) -> AnyPublisher<DetailResponse, Error> {
//      Future { promise in
//          Task {
//              do {
//                  guard let url = URL(string: self._endpoint) else {
//                      promise(.failure(URLError(.badURL)))
//                      return
//                  }
//
//                  let data = try await AF.request(url)
//                      .validate()
//                      .serializingDecodable(DetailResponse.self)
//                      .value
//
//                  // Ensure we fulfill the promise on the main actor
//                  await MainActor.run {
//                      promise(.success(data))
//                  }
//
//              } catch {
//                  let mappedError: Error
//                  if let afError = error.asAFError,
//                     let urlError = afError.underlyingError as? Foundation.URLError  {
//                      mappedError = urlError
//                  } else {
//                      mappedError = URLError(.cannotParseResponse)
//                  }
//
//                  await MainActor.run {
//                      promise(.failure(mappedError))
//                  }
//              }
//          }
//      }
//      .eraseToAnyPublisher()
//  }
  
//  public func execute(request: Any?) -> AnyPublisher<DetailResponse, Error> {
//      Future { promise in
//          Task.detached {
//              guard let url = URL(string: self._endpoint) else {
//                  promise(.failure(Foundation.URLError(.badURL)))
//                  return
//              }
//
//              do {
//                  let data = try await AF.request(url)
//                      .validate()
//                      .serializingDecodable(DetailResponse.self)
//                      .value
//
//                  promise(.success(data))
//              } catch {
//                  if let afError = error.asAFError,
//                     let underlying = afError.underlyingError as? Foundation.URLError {
//                      promise(.failure(underlying))
//                  } else {
//                      promise(.failure(error))
//                  }
//              }
//          }
//      }
//      .eraseToAnyPublisher()
//  }
  
//  public func execute(request: Any?) -> AnyPublisher<DetailResponse, Error> {
//      Future { promise in
//          guard let url = URL(string: self._endpoint) else {
//              promise(.failure(Foundation.URLError(.badURL)))
//              return
//          }
//
//          // Create a local copy of the promise (to break sendable capture)
//          let safePromise: @Sendable (Result<DetailResponse, any Error>) -> Void = promise
//
//          AF.request(url)
//              .validate()
//              .responseDecodable(of: DetailResponse.self) { response in
//                  // This closure may be @Sendable internally, so use safePromise
//                  switch response.result {
//                  case .success(let value):
//                      safePromise(.success(value))
//                  case .failure(let afError):
//                      // Provide better error mapping
//                      let mappedError: Error
//                      if let urlError = afError.underlyingError as? Foundation.URLError {
//                          mappedError = urlError
//                      } else {
//                          mappedError = Foundation.URLError(.cannotParseResponse)
//                      }
//                      safePromise(.failure(mappedError))
//                  }
//              }
//      }
//      .eraseToAnyPublisher()
//  }
  
//  public func execute(request: Any?) -> AnyPublisher<DetailResponse, Error> {
//      Future { promise in
//          Task.detached(priority: .userInitiated) {
//              guard let url = URL(string: self._endpoint) else {
//                  promise(.failure(URLError(.badURL)))
//                  return
//              }
//
//              AF.request(url)
//                  .validate()
//                  .responseDecodable(of: DetailResponse.self) { response in
//                      switch response.result {
//                      case .success(let value):
//                          promise(.success(value))
//                      case .failure(let afError):
//                          if let underlying = afError.underlyingError as? Foundation.URLError {
//                              promise(.failure(underlying))
//                          } else {
//                              promise(.failure(Foundation.URLError(.cannotParseResponse)))
//                          }
//                      }
//                  }
//          }
//      }
//      .eraseToAnyPublisher()
//  }

//  public func execute(request: Any?) -> AnyPublisher<DetailResponse, Error> {
//    return Future<DetailResponse, Error> { @Sendable completion in
//      if let url = URL(string: _endpoint) {
//        AF.request(url)
//          .validate()
//          .responseDecodable(of: DetailResponse.self) { response in
//            switch response.result {
//            case .success(let value):
//              completion(.success(value))
//            case .failure:
//              completion(.failure(URLError.invalidResponse))
//            }
//          }
//      }
//    }.eraseToAnyPublisher()
//  }
  
//  public func execute(request: Any?) async throws -> DetailResponse {
//    guard let url = URL(string: _endpoint) else {
//      throw URLError(.badURL)
//    }
//
//    let response = try await AF.request(url)
//      .validate()
//      .serializingDecodable(DetailResponse.self)
//      .value
//
//    return response
//  }
}
