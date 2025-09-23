//
//  DetailViewModel.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI
import Alamofire
import Combine

class GameDetailPresenter: ObservableObject {
  
  private let gameDetailUseCase: GameDetailUseCase
  private var cancellables: Set<AnyCancellable> = []

  @Published var game: GameDetailModel?
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  @Published var isFavorite = false

  init(gameDetailUseCase: GameDetailUseCase) {
    self.gameDetailUseCase = gameDetailUseCase
    getGameDetail()
  }
  
  func getGameDetail() {
    loadingState = true
    gameDetailUseCase.getGameDetail()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { game in
        self.game = game
        self.checkFavorite(id: game.id)
      })
      .store(in: &cancellables)
   }
  
    func checkFavorite(id: Int) {
      gameDetailUseCase.isGameExist(id: id)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { exists in
          self.isFavorite = exists
        })
        .store(in: &cancellables)
    }
  
    func toggleFavorite() {
      guard let game = game else { return }
  
      if isFavorite {
        deleteFavorite(id: game.id)
      } else {
        addFavorite(game: game)
      }
    }
  
    private func addFavorite(game: GameDetailModel) {
      gameDetailUseCase.addFavorite(game: game)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { _ in
          self.isFavorite.toggle()
        })
        .store(in: &cancellables)
    }
  
    private func deleteFavorite(id: Int?) {
      guard let id = id else { return }
      
      gameDetailUseCase.deleteFavorite(id: id)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { _ in
          self.isFavorite.toggle()
        })
        .store(in: &cancellables)
    }
}
