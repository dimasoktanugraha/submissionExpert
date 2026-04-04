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
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
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
  
    func get(id: String) -> AnyPublisher<[FavoriteModuleEntity], any Error> {
        return Fail(error: URLError(.cannotFindHost)).eraseToAnyPublisher()
    }

    func update(id: Int, entity: FavoriteModuleEntity) -> AnyPublisher<Bool, any Error> {
        return Just(true).setFailureType(to: (any Error).self).eraseToAnyPublisher()
    }

    func addAll(entities: [FavoriteModuleEntity]) -> AnyPublisher<Bool, any Error> {
        return Just(true).setFailureType(to: (any Error).self).eraseToAnyPublisher()
    }
}

struct FavoriteGameInteractorTests {
    @Test("FavoriteGameInteractor - getFavoriteGames success")
    func testGetFavoriteGamesSuccess() async throws {
        let mockDataSource = MockFavoritesLocaleDataSource()
        let mapper = FavoriteTransformer()
      
        let repository = FavoritesRepository(localeDataSource: mockDataSource, mapper: mapper)
      
//        let interactor = FavoriteInteractor(repository: repository)
        let interactor = FavoriteInteractor<MockFavoritesLocaleDataSource>(repository: repository)

        let entity1 = FavoriteModuleEntity()
        entity1.id = 1
        entity1.name = "GTA-V"
              
        let entity2 = FavoriteModuleEntity()
        entity2.id = 2
        entity2.name = "ML"
              
        mockDataSource.mockEntities = [entity1, entity2]
      
//        mockDataSource.mockEntities = [
//          FavoriteModuleEntity(id: 1, name: "GTA-V", released: "2025-01-01", backgroundImage: "gta.png", rating: 4.9),
//          FavoriteModuleEntity(id: 2, name: "ML", released: "2025-01-02", backgroundImage: "ml.png", rating: 4.5)
//        ]
//        mockRepository.favoritesToReturn = expectedGames

        let result = try await interactor.getFavorites()
            .values
            .first(where: { _ in true })
      
        #expect(result?.count == 2)
        #expect(result?.first?.name == "GTA-V")

//        #expect(result?.count == expectedGames.count)
//        #expect(result?.first?.name == "GTA-V")
    }

    @Test("FavoriteGameInteractor - getFavoriteGames failure")
    func testGetFavoriteGamesFailure() async throws {
        enum TestError: Error { case someError }
      
        let mockDataSource = MockFavoritesLocaleDataSource()
        let mapper = FavoriteTransformer()
      
        mockDataSource.shouldReturnError = true
        
        let mockRepository = FavoritesRepository(localeDataSource: mockDataSource, mapper: mapper)
      
//        let mockRepository = MockGameRepository()
//        mockRepository.errorToReturn = TestError.someError
//
//        let interactor = FavoriteInteractor(repository: mockRepository)
      
        let interactor = FavoriteInteractor(repository: mockRepository)

        do {
            _ = try await interactor.getFavorites()
                .values
                .first(where: { _ in true })
          Issue.record("Expected failure but got success")
        } catch {
            #expect(error is TestError)
        }
    }
}
