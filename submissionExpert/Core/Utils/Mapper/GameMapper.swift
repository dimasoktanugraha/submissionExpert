//
//  GameMapper.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation

final class GameMapper {

  static func mapGameResponsesToDomains(
    input gameResponses: [GameResponse]
  ) -> [GameModel] {

    return gameResponses.map { result in
      return GameModel(
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
  ) -> [GameModel] {
    return gameEntities.map { result in
      return GameModel(
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
  
  static func mapGameDetailResponsesToDomains(
    input detailResponses: GameDetailResponse
  ) -> GameDetailModel {

    return GameDetailModel(
      id: detailResponses.id ?? 0,
      name: detailResponses.name ?? "Unknow",
      released: detailResponses.released ?? "",
      backgroundImage: detailResponses.backgroundImage ?? "",
      rating: detailResponses.rating ?? 0.0,
      description: detailResponses.description ?? ""
    )
  }
  
  static func mapFavoriteEntitesToDomains(
    input favoriteEntities: [FavoriteEntity]
  ) -> [GameModel] {

    return favoriteEntities.map { result in
      return GameModel(
        id: result.id,
        name: result.name,
        released: result.released,
        backgroundImage: result.backgroundImage,
        rating: result.rating
      )
    }
  }
  
  static func mapGameDetailModelToFavoriteEntities(
    input gameDetailResponses: GameDetailModel
  ) -> FavoriteEntity {
    let newFavorite = FavoriteEntity()
    newFavorite.id = gameDetailResponses.id
    newFavorite.name = gameDetailResponses.name
    newFavorite.released = gameDetailResponses.released
    newFavorite.backgroundImage = gameDetailResponses.backgroundImage
    newFavorite.rating = gameDetailResponses.rating
    newFavorite.desc = gameDetailResponses.description
    return newFavorite
  }
}
