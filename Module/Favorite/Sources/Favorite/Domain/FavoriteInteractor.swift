//
//  FavoriteInteractor.swift
//  Favorite
//
//  Created by Dimas Oktanugraha on 06/11/25.
//

import Combine
import CorePackage
import Shared

public struct FavoriteInteractor: FavoriteUseCase {
  private let repository: FavoritesRepository<FavoritesLocaleDataSource, FavoriteTransformer>

  public init(repository: FavoritesRepository<FavoritesLocaleDataSource, FavoriteTransformer>) {
    self.repository = repository
  }
  
  public func getFavorites() -> AnyPublisher<[GameDomainModel], Error> {
    repository.execute(request: nil)
  }
  
  public func addFavorite(game: GameDomainModel) -> AnyPublisher<Bool, Error> {
    let entity = FavoriteModuleEntity()
    entity.id = game.id
    entity.name = game.name
    entity.released = game.released
    entity.backgroundImage = game.backgroundImage
    entity.rating = game.rating
    return repository.add(entity: entity)
  }
  
  public func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
    repository.delete(id: id)
  }
  
  public func isFavorite(id: Int) -> AnyPublisher<Bool, Error> {
    repository.isExists(id: id)
  }
}
