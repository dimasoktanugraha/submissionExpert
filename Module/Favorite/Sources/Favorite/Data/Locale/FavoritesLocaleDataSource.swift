//
//  GetFavoritesLocaleDataSource.swift
//  Favorite
//
//  Created by Dimas Oktanugraha on 06/11/25.
//

import CorePackage
import Combine
import RealmSwift
import Foundation

public struct FavoritesLocaleDataSource: LocaleDataSource {

  public typealias Request = FavoriteModuleEntity
  public typealias Response = FavoriteModuleEntity
  
  private let _realm: Realm
  
  public init(realm: Realm) {
      _realm = realm
  }
  
  public func list() -> AnyPublisher<[FavoriteModuleEntity], Error> {
    print("🟢 FavoritesLocaleDataSource: list ")
      return Future<[FavoriteModuleEntity], Error> { completion in
          let favorites: Results<FavoriteModuleEntity> = {
            _realm.objects(FavoriteModuleEntity.self)
          }()
          completion(.success(favorites.toArray(ofType: FavoriteModuleEntity.self)))
        
      }.eraseToAnyPublisher()
  }
  
  public func add(entity: Request) -> AnyPublisher<Bool, any Error> {
    return Future<Bool, Error> { completion in
      do {
          try _realm.write {
            _realm.add(entity, update: .all)
            completion(.success(true))
          }
      } catch {
          completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
  
  public func isExists(id: Int) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let favorite = _realm.object(ofType: FavoriteModuleEntity.self, forPrimaryKey: id)
      completion(.success(favorite != nil))
    }.eraseToAnyPublisher()
  }
  
  public func delete(id: Int) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let favorite = _realm.object(ofType: FavoriteModuleEntity.self, forPrimaryKey: id) {
        do {
          try _realm.write {
            _realm.delete(favorite)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
    
  public func get(id: String) -> AnyPublisher<FavoriteModuleEntity, Error> {
      fatalError()
  }
  
  public func update(id: Int, entity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
      fatalError()
  }

  public func getById(id: Int) -> AnyPublisher<FavoriteModuleEntity, any Error> {
    fatalError()
  }
  
  public func addAll(entities: [Request]) -> AnyPublisher<Bool, any Error> {
    fatalError()
  }
}
