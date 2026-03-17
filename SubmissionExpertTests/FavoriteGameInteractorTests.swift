//
//  FavoriteGameInteractorTest.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Testing
import Combine
import Shared
@testable import SubmissionExpert

struct FavoriteGameInteractorTests {
    @Test("FavoriteGameInteractor - getFavoriteGames success")
    func testGetFavoriteGamesSuccess() async throws {
        let mockRepository = MockGameRepository()
        let interactor = FavoriteGameInteractor(repository: mockRepository)

        let expectedGames = [
            GameModel(id: 1, name: "GTA-V", released: "2025-01-01", backgroundImage: "gta.png", rating: 4.9),
            GameModel(id: 2, name: "ML", released: "2025-01-02", backgroundImage: "ml.png", rating: 4.5)
        ]
        mockRepository.favoritesToReturn = expectedGames

        let result = try await interactor.getFavoriteGames()
            .values
            .first(where: { _ in true })

        #expect(result?.count == expectedGames.count)
        #expect(result?.first?.name == "GTA-V")
    }

    @Test("FavoriteGameInteractor - getFavoriteGames failure")
    func testGetFavoriteGamesFailure() async throws {
        enum TestError: Error { case someError }
        let mockRepository = MockGameRepository()
        mockRepository.errorToReturn = TestError.someError

        let interactor = FavoriteGameInteractor(repository: mockRepository)

        do {
            _ = try await interactor.getFavoriteGames()
                .values
                .first(where: { _ in true })
            Issue.record("Expected failure but got success")
        } catch {
            #expect(error is TestError)
        }
    }
}
