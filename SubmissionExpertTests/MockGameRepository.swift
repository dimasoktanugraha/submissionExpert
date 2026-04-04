//
//  MockGameRepository.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Combine
import Shared
import Detail
import CorePackage

@testable import SubmissionExpert
class MockGameRepository: Repository, GameRepositoryProtocol {
  
  public typealias Request = Any
  public typealias Response = DetailDomainModel

  var gamesToReturn: [GameDomainModel] = []
  var favoritesToReturn: [GameDomainModel] = []
  var gameDetailToReturn: DetailDomainModel = DetailDomainModel(
    id: 0,
    name: "",
    released: "",
    backgroundImage: "",
    rating: 0.0,
    description: ""
  )
  var isExistToReturn: Bool = true
  var errorToReturn: Error?
  
  func getGames(query: String) -> AnyPublisher<[GameDomainModel], any Error> {
    if let error = errorToReturn {
        return Fail(error: error).eraseToAnyPublisher()
    } else {
      return Just(gamesToReturn)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
  }
  
  func execute(request: Any?) -> AnyPublisher<DetailDomainModel, Error> {
      if let error = errorToReturn {
          return Fail(error: error).eraseToAnyPublisher()
      } else {
          return Just(gameDetailToReturn)
              .setFailureType(to: Error.self)
              .eraseToAnyPublisher()
      }
  }
  
  func getGameDetail(id: Int) -> AnyPublisher<DetailDomainModel, Error> {
    return execute(request: nil)
  }
  
  func isGameExist(id: Int) -> AnyPublisher<Bool, any Error> {
    if let error = errorToReturn {
      return Fail(error: error).eraseToAnyPublisher()
    } else {
      return Just(isExistToReturn)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
  }
  
  func addFavorite(game: DetailDomainModel) -> AnyPublisher<Bool, any Error> {
    if let error = errorToReturn {
      return Fail(error: error).eraseToAnyPublisher()
    } else {
      return Just(true)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
  }
  
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
    if let error = errorToReturn {
      return Fail(error: error).eraseToAnyPublisher()
    } else {
      return Just(true)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
  }

  func getFavorites() -> AnyPublisher<[GameDomainModel], Error> {
      if let error = errorToReturn {
        return Fail(error: error).eraseToAnyPublisher()
      } else {
        return Just(favoritesToReturn)
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
      }
  }
}
