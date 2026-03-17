//
//  FavoriteTransformer.swift
//  Favorite
//
//  Created by Dimas Oktanugraha on 06/11/25.
//

import CorePackage
import Shared

public struct FavoriteTransformer: Mapper {

  public typealias Response = Never
  public typealias Entity = [FavoriteModuleEntity]
  public typealias Domain = [GameDomainModel]
    
  public init() {}
  
  public func transformResponseToDomain(response: Never) -> [Shared.GameDomainModel] {
    
      fatalError("transformResponseToDomain not implemented")
  }
  
  public func transformResponseToEntity(response: Never) -> [FavoriteModuleEntity] {
    
      fatalError("transformResponseToEntity not implemented")
  }
    
  public func transformEntityToDomain(entity: [FavoriteModuleEntity]) -> [GameDomainModel] {
      return entity.map { result in
        return GameDomainModel(
          id: result.id,
          name: result.name,
          released: result.released,
          backgroundImage: result.backgroundImage,
          rating: result.rating
        )
      }
  }
}
