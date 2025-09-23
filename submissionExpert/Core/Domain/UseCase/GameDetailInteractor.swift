//
//  DetailInteractor.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import Combine

protocol GameDetailUseCase {
  
  func getGameDetail() -> AnyPublisher<GameDetailModel, Error>
  func isGameExist(id: Int) -> AnyPublisher<Bool, Error>
  func addFavorite(game: GameDetailModel) -> AnyPublisher<Bool, Error>
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
  
}

class GameDetailInteractor: GameDetailUseCase {

  private let repository: GameRepositoryProtocol
  private let id: Int

  required init(repository: GameRepositoryProtocol, id: Int) {
    self.repository = repository
    self.id = id
  }

  func getGameDetail() -> AnyPublisher<GameDetailModel, Error> {
    return repository.getGameDetail(id: id)
  }

  func isGameExist(id: Int) -> AnyPublisher<Bool, Error> {
    return repository.isGameExist(id: id)
  }
  
  func addFavorite(game: GameDetailModel) -> AnyPublisher<Bool, Error> {
    return repository.addFavorite(game: game)
  }
  
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
    return repository.deleteFavorite(id: id)
  }
}
