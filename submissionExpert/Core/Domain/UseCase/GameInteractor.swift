//
//  GameInteractor.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import Combine
import Shared

protocol GameUseCase {
  func getGames(query: String) -> AnyPublisher<[GameDomainModel], Error>
}

class GameInteractor: GameUseCase {

  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getGames(query: String) -> AnyPublisher<[GameDomainModel], Error> {
    return repository.getGames(query: query)
  }

}
