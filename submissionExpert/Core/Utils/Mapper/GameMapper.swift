//
//  GameMapper.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import Shared

final class GameMapper {
  
  static func mapGameResponsesToDomains(
    input gameResponses: [GameResponse]
  ) -> [GameDomainModel] {

    return gameResponses.map { result in
      return GameDomainModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknow",
        released: result.released ?? "",
        backgroundImage: result.backgroundImage ?? "",
        rating: result.rating ?? 0.0
      )
    }
  }
  
  static func mapGameEntitiesToDomains(
    input gameEntities: [GameEntity]
  ) -> [GameDomainModel] {
    return gameEntities.map { result in
      return GameDomainModel(
        id: result.id,
        name: result.name,
        released: result.released,
        backgroundImage: result.backgroundImage,
        rating: result.rating
      )
    }
  }
  
  static func mapGameResponsesToEntities(
    input gameResponses: [GameResponse]
  ) -> [GameEntity] {
    return gameResponses.map { result in
      let newGame = GameEntity()
      newGame.id = result.id ?? 0
      newGame.name = result.name ?? "Unknow"
      newGame.released = result.released ?? ""
      newGame.backgroundImage = result.backgroundImage ?? ""
      newGame.rating = result.rating ?? 0.0
      return newGame
    }
  }
}
