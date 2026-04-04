//
//  GameDetailInteractor.swift
//  SubmissionExpertTests
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Testing
import Combine
import Detail
import Shared
import CorePackage

@testable import SubmissionExpert

class MockDetailUseCase: DetailUseCase {
    typealias Request = Any
    typealias Response = DetailDomainModel
    
    var result: AnyPublisher<DetailDomainModel, Error>!

    func execute(request: Any?) -> AnyPublisher<DetailDomainModel, Error> {
        return result
    }
}

struct GameDetailInteractorTests {
    @Test("GameDetailInteractor - getGameDetail success")
    func testGetGameDetailSuccess() async throws {
        let mockRepository = MockGameRepository()
//        let expectedDetail = DetailDomainModel(
//            id: 1,
//            name: "Elden Ring",
//            released: "2025-01-01",
//            backgroundImage: "elden.png",
//            rating: 5.0,
//            description: "Epic RPG"
//        )
//        mockRepository.gameDetailToReturn = expectedDetail
//
//        let interactor = GameDetailInteractor(repository: mockRepository, id: 1)
      
        let interactor = Interactor(repository: mockRepository)
      
        let expectedDetail = DetailDomainModel(
            id: 1,
            name: "Elden Ring",
            released: "2025-01-01",
            backgroundImage: "elden.png",
            rating: 5.0,
            description: "Epic RPG"
        )
        mockRepository.gameDetailToReturn = expectedDetail

//        let result = try await interactor.getGameDetail()
//            .values
//            .first(where: { _ in true })
      
        let result = try await interactor.execute(request: nil)
          .values
          .first(where: { _ in true })

        #expect(result?.id == 1)
        #expect(result?.name == "Elden Ring")
    }

    @Test("GameDetailInteractor - getGameDetail failure")
    func testGetGameDetailFailure() async throws {
        enum TestError: Error { case someError }
        let mockRepository = MockGameRepository()
        mockRepository.errorToReturn = TestError.someError

//        let interactor = GameDetailInteractor(repository: mockRepository, id: 1)

        let interactor = Interactor(repository: mockRepository)
      
        do {
//            _ = try await interactor.getGameDetail()
//                .values
//                .first(where: { _ in true })
//          
            _ = try await interactor.execute(request: nil)
                  .values
                  .first(where: { _ in true })
            Issue.record("Expected failure but got success")
        } catch {
            #expect(error is TestError)
        }
    }
}
