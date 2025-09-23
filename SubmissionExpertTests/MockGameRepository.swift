//
//  MockGameRepository.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Combine

@testable import SubmissionExpert
class MockGameRepository: GameRepositoryProtocol {

  var gamesToReturn: [GameModel] = []
  var favoritesToReturn: [GameModel] = []
  var gameDetailToReturn: GameDetailModel = GameDetailModel(
    id: 0,
    name: "",
    released: "",
    backgroundImage: "",
    rating: 0.0,
    description: ""
  )
  var isExistToReturn: Bool = true
  var errorToReturn: Error?
  
  func getGames(query: String) -> AnyPublisher<[SubmissionExpert.GameModel], any Error> {
    if let error = errorToReturn {
        return Fail(error: error).eraseToAnyPublisher()
    } else {
      return Just(gamesToReturn)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
  }
  
  func getGameDetail(id: Int) -> AnyPublisher<SubmissionExpert.GameDetailModel, any Error> {
    if let error = errorToReturn {
      return Fail(error: error).eraseToAnyPublisher()
    } else {
      return Just(gameDetailToReturn)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
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
  
  func addFavorite(game: SubmissionExpert.GameDetailModel) -> AnyPublisher<Bool, any Error> {
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

  func getFavorites() -> AnyPublisher<[GameModel], Error> {
      if let error = errorToReturn {
        return Fail(error: error).eraseToAnyPublisher()
      } else {
        return Just(favoritesToReturn)
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
      }
  }
}
