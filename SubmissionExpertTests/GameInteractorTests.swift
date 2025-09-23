//
//  FavoriteGameInteractorTest.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Testing
import Combine

@testable import SubmissionExpert

struct GameInteractorTests {
  
  var cancellables = Set<AnyCancellable>()
  
  @Test("GameInteractor - getGames success")
  func testGetGamesSuccess() async throws {
      let mockRepository = MockGameRepository()
      let interactor = GameInteractor(repository: mockRepository)

      let expectedGames = [
          GameModel(id: 1, name: "GTA-V", released: "2025-01-01", backgroundImage: "image.png", rating: 4.9),
          GameModel(id: 2, name: "ML", released: "2025-01-02", backgroundImage: "mimage.png", rating: 4.5)
      ]
      mockRepository.gamesToReturn = expectedGames

      let result = try await interactor.getGames(query: "")
          .values
          .first(where: { _ in true })

      #expect(result?.count == expectedGames.count)
      #expect(result?.first?.name == "GTA-V")
  }
  
  @Test("GameInteractor - getGames failure")
  func testGetGamesFailure() async throws {
      enum TestError: Error { case someError }
      let mockRepository = MockGameRepository()
      mockRepository.errorToReturn = TestError.someError
      let interactor = GameInteractor(repository: mockRepository)

      do {
          _ = try await interactor.getGames(query: "")
              .values
              .first(where: { _ in true })
          Issue.record("Expected failure but got success")
      } catch {
          #expect(error is TestError)
      }
  }
}
