//
//  GameRouter.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import SwiftUI

class GameRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let gameDetailUseCase = Injection.init().provideGameDetail(id: game.id)
    let presenter = GameDetailPresenter(gameDetailUseCase: gameDetailUseCase)
    return DetailView(presenter: presenter)
  }

}
