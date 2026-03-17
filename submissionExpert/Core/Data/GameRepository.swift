//
//  GameRepository.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import Combine
import Shared

protocol GameRepositoryProtocol {

  func getGames(query: String) -> AnyPublisher<[GameDomainModel], Error>
}

final class GameRepository: NSObject {

  typealias GameInstance = (RemoteDataSource, LocaleDataSource) -> GameRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(remote: RemoteDataSource, locale: LocaleDataSource) {
    self.remote = remote
    self.locale = locale
  }

  static let sharedInstance: GameInstance = { remoteRepo, localeRepo in
    return GameRepository(remote: remoteRepo, locale: localeRepo)
  }

}

extension GameRepository: GameRepositoryProtocol {
  
  func getGames(query: String) -> AnyPublisher<[GameDomainModel], Error> {
    if query.isEmpty {
      return self.locale.getGames()
        .flatMap { result -> AnyPublisher<[GameDomainModel], Error> in
          if result.isEmpty {
            return self.remote.getGames(query: query)
              .map { GameMapper.mapGameResponsesToEntities(input: $0) }
              .flatMap { self.locale.addGames(from: $0) }
              .filter { $0 }
              .flatMap { _ in self.locale.getGames()
                .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
              }
              .eraseToAnyPublisher()
          } else {
            return self.locale.getGames()
              .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
              .eraseToAnyPublisher()
          }
        }.eraseToAnyPublisher()
    } else {
      return self.remote.getGames(query: query)
        .map { GameMapper.mapGameResponsesToDomains(input: $0) }
        .eraseToAnyPublisher()
    }
  }
}
