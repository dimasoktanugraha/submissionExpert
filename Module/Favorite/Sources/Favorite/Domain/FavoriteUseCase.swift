//
//  FavoriteUseCase.swift
//  Favorite
//
//  Created by Dimas Oktanugraha on 06/11/25.
//

import Combine
import Shared

public protocol FavoriteUseCase {
  func getFavorites() -> AnyPublisher<[GameDomainModel], Error>
  func addFavorite(game: GameDomainModel) -> AnyPublisher<Bool, Error>
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
  func isFavorite(id: Int) -> AnyPublisher<Bool, Error>
}
