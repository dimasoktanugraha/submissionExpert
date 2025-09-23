//
//  GameInteractor.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import Combine

protocol GameUseCase {
  func getGames(query: String) -> AnyPublisher<[GameModel], Error>
}

class GameInteractor: GameUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getGames(query: String) -> AnyPublisher<[GameModel], Error> {
    return repository.getGames(query: query)
  }

}
