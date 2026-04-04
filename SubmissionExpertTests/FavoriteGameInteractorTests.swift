//
//  FavoriteGameInteractorTest.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Testing
import Combine
import CorePackage
import Shared
import Favorite
import RealmSwift
import Foundation

@testable import SubmissionExpert

class MockFavoritesLocaleDataSource: CorePackage.LocaleDataSource {
    typealias Request = FavoriteModuleEntity
    typealias Response = FavoriteModuleEntity

    var mockEntities: [FavoriteModuleEntity] = []
    var shouldReturnError = false
  
    func list() -> AnyPublisher<[FavoriteModuleEntity], Error> {
        if shouldReturnError {
            let error = Foundation.URLError(.badServerResponse)
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(mockEntities)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
  
    func getById(id: Int) -> AnyPublisher<FavoriteModuleEntity, Error> {
        if let entity = mockEntities.first(where: { $0.id == id }) {
            return Just(entity).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        return Fail(error: URLError(.fileDoesNotExist)).eraseToAnyPublisher()
    }

    func add(entity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
          return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func delete(id: Int) -> AnyPublisher<Bool, Error> {
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
  
    func isExists(id: Int) -> AnyPublisher<Bool, Error> {
      let exists = mockEntities.contains(where: { $0.id == id })
      return Just(exists)
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
    }
  
    func get(id: String) -> AnyPublisher<FavoriteModuleEntity, Error> {
        return Fail(error: URLError(.cannotFindHost)).eraseToAnyPublisher()
    }

    func update(id: Int, entity: FavoriteModuleEntity) -> AnyPublisher<Bool, Error> {
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func addAll(entities: [FavoriteModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Just(true).setFailureType(to: (any Error).self).eraseToAnyPublisher()
    }
}

struct FavoriteGameInteractorTests {
    @Test("FavoriteGameInteractor - getFavoriteGames success")
    func testGetFavoriteGamesSuccess() async throws {
        let mockDataSource = MockFavoritesLocaleDataSource()
        let mapper = FavoriteTransformer()
      
        let repository = FavoritesRepository(localeDataSource: mockDataSource, mapper: mapper)
      
        let interactor = FavoriteInteractor<MockFavoritesLocaleDataSource>(repository: repository)

        let entity1 = FavoriteModuleEntity()
        entity1.id = 1
        entity1.name = "GTA-V"
        entity1.released = "2025-01-01"
        entity1.backgroundImage = "gta.png"
        entity1.rating = 4.9
        entity1.desc = "GTA-V"
              
        let entity2 = FavoriteModuleEntity()
        entity2.id = 2
        entity2.name = "ML"
        entity2.released = "2025-01-01"
        entity2.backgroundImage = "ml.png"
        entity2.rating = 4.9
        entity2.desc = "ML"
              
        mockDataSource.mockEntities = [entity1, entity2]
      
        let result = try await interactor.getFavorites()
            .values
            .first(where: { _ in true })
      
        #expect(result?.count == 2)
        #expect(result?.first?.name == "GTA-V")
    }

    @Test("FavoriteGameInteractor - getFavoriteGames failure")
    func testGetFavoriteGamesFailure() async throws {
        enum TestError: Error { case someError }
      
        let mockDataSource = MockFavoritesLocaleDataSource()
        let mapper = FavoriteTransformer()
      
        mockDataSource.shouldReturnError = true
        
        let mockRepository = FavoritesRepository(localeDataSource: mockDataSource, mapper: mapper)
      
        let interactor = FavoriteInteractor<MockFavoritesLocaleDataSource>(repository: mockRepository)

        do {
            _ = try await interactor.getFavorites()
                .values
                .first(where: { _ in true })
          Issue.record("Expected failure but got success")
        } catch {
          let isURLError = error is Foundation.URLError
          #expect(isURLError)
          
          if let urlError = error as? Foundation.URLError {
              #expect(urlError.code == Foundation.URLError.Code.badServerResponse)
          }
        }
    }
}
