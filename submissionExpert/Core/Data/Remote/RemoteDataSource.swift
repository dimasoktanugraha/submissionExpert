//
//  RemoteDataSource.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
  func getGames(query: String) -> AnyPublisher<[GameResponse], Error>
  func getGameDetail(id: Int) -> AnyPublisher<GameDetailResponse, Error>

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getGames(query: String) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.games(query: query).url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getGameDetail(id: Int) -> AnyPublisher<GameDetailResponse, Error> {
    return Future<GameDetailResponse, Error> { completion in
      if let url = URL(string: Endpoints.Gets.detail(id: id).url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameDetailResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }

}
