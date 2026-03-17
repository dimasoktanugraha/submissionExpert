//
//  FavoritesRepository.swift
//  Favorite
//
//  Created by Dimas Oktanugraha on 06/11/25.
//

import CorePackage
import Combine
import Shared
 
public struct FavoritesRepository<
  FavoritesLocaleDataSource: LocaleDataSource,
  Transformer: Mapper
>: Repository where

  FavoritesLocaleDataSource.Request == FavoriteModuleEntity,
  FavoritesLocaleDataSource.Response == FavoriteModuleEntity,
  Transformer.Entity == [FavoriteModuleEntity],
  Transformer.Domain == [GameDomainModel] {
  
  public typealias Request = Any
  public typealias Response = [GameDomainModel]
  
  private let _localeDataSource: FavoritesLocaleDataSource
  private let _mapper: Transformer
  
  public init(
      localeDataSource: FavoritesLocaleDataSource,
      mapper: Transformer) {
      
      _localeDataSource = localeDataSource
      _mapper = mapper
  }
  
  public func add(entity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
    return _localeDataSource.add(entity: entity).eraseToAnyPublisher()
  }
  
  public func isExists(id: Int) -> AnyPublisher<Bool, Error> {
    return _localeDataSource.isExists(id: id).eraseToAnyPublisher()
  }
  
  public func delete(id: Int) -> AnyPublisher<Bool, Error> {
    return _localeDataSource.delete(id: id).eraseToAnyPublisher()
  }
    
  public func execute(request: Any?) -> AnyPublisher<[GameDomainModel], Error> {
    print("🟢 FavoritesRepository: Execute ")
    return _localeDataSource.list().map {
      _mapper.transformEntityToDomain(entity: $0)
    }.eraseToAnyPublisher()
  }
}
