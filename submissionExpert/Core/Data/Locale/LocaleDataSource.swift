//
//  LocaleDataSource.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Foundation
import RealmSwift
import Combine
 
protocol LocaleDataSourceProtocol: AnyObject {
  
  func getGames() -> AnyPublisher<[GameEntity], Error>
  func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
  func getFavorites() -> AnyPublisher<[FavoriteEntity], Error>
  func isGameExist(id: Int) -> AnyPublisher<Bool, Error>
  func addFavorite(from game: FavoriteEntity) -> AnyPublisher<Bool, Error>
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
}
 
final class LocaleDataSource: NSObject {
 
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
 
  func getGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
        }()
        completion(.success(games.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
 
  func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in games {
              realm.add(game, update: .all)
            }
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
  
  func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
    return Future<[FavoriteEntity], Error> { completion in
      if let realm = self.realm {
        let favorites: Results<FavoriteEntity> = {
          realm.objects(FavoriteEntity.self)
        }()
        completion(.success(favorites.toArray(ofType: FavoriteEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func isGameExist(id: Int) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        let favorite = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: id)
        completion(.success(favorite != nil))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addFavorite(from game: FavoriteEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(game, update: .all)
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
  
  func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        if let favorite = realm.object(ofType: FavoriteEntity.self, forPrimaryKey: id) {
          do {
            try realm.write {
              realm.delete(favorite)
              completion(.success(true))
            }
          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}
 
extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
