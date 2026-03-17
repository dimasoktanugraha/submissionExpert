//
//  GameViewModel.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI
import Combine
import Shared

@MainActor
class GamePresenter: ObservableObject {
  
  private let router = GameRouter()
  private let gameUseCase: GameUseCase
  
  @Published var games: [GameDomainModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  @Published var searchText: String = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  init(gameUseCase: GameUseCase) {
    self.gameUseCase = gameUseCase
    
    $searchText
      .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
      .removeDuplicates()
      .sink { [weak self] query in
        self?.getGames(query: query)
      }
      .store(in: &cancellables)
  }
  
  func getGames(query: String) {
    
    loadingState = true
    gameUseCase.getGames(query: query)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
   }

  func linkBuilder<Content: View>(
    for game: GameDomainModel,
    @ViewBuilder content: () -> Content
   ) -> some View {
     NavigationLink(
      destination: router.makeDetailView(for: game.id)) { content() }
   }
}
