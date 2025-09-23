//
//  FavoriteGameInteractor.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Foundation
import Combine

protocol FavoriteGameUseCase {
  
  func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
}

class FavoriteGameInteractor: FavoriteGameUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
    return repository.getFavorites()
  }

}
