//
//  FavoriteViewModel.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 12/09/25.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
  
  private let router = GameRouter()
  private let favoriteUseCase: FavoriteGameUseCase
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: FavoriteGameUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getGames() {
    loadingState = true
    favoriteUseCase.getFavoriteGames()
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
   for game: GameModel,
   @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
     destination: router.makeDetailView(for: game)) { content() }
  }

}
