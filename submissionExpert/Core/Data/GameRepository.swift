//
//  GameRepository.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {

  func getGames(query: String) -> AnyPublisher<[GameModel], Error>
  func getGameDetail(id: Int) -> AnyPublisher<GameDetailModel, Error>
  func getFavorites() -> AnyPublisher<[GameModel], Error>
  func isGameExist(id: Int) -> AnyPublisher<Bool, Error>
  func addFavorite(game: GameDetailModel) -> AnyPublisher<Bool, Error>
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
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
  
  func getFavorites() -> AnyPublisher<[GameModel], Error> {
    return self.locale.getFavorites()
      .map { GameMapper.mapFavoriteEntitesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func isGameExist(id: Int) -> AnyPublisher<Bool, Error> {
    return self.locale.isGameExist(id: id)
      .eraseToAnyPublisher()
  }
  
  func addFavorite(game: GameDetailModel) -> AnyPublisher<Bool, Error> {
    let favoriteGame = GameMapper.mapGameDetailModelToFavoriteEntities(input: game)
    return self.locale.addFavorite(from: favoriteGame)
      .eraseToAnyPublisher()
  }
  
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
    return self.locale.deleteFavorite(id: id)
      .eraseToAnyPublisher()
  }
  
  func getGames(query: String) -> AnyPublisher<[GameModel], Error> {
    if query.isEmpty {
      return self.locale.getGames()
        .flatMap { result -> AnyPublisher<[GameModel], Error> in
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
  
  func getGameDetail(id: Int) -> AnyPublisher<GameDetailModel, Error> {
    return self.remote.getGameDetail(id: id)
      .map { GameMapper.mapGameDetailResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
}
