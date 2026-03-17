//
//  GameRouter.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import SwiftUI
import Core
import Detail
import Shared

class GameRouter {

  @MainActor
  func makeDetailView(for game: GameModel) -> some View {
    
    print("🟢 Game ID:", game.id)

    guard let detailUseCase: Interactor<
      Any,
      DetailDomainModel,
      GetDetailRepository<
        GetDetailRemoteDataSource,
        DetailTransformer>
    > = Injection.init().provideDetail(id: game.id) else {
        fatalError("Failed to create detail use case")
    }
    
    let presenter = GetByIdPresenter(useCase: detailUseCase)
    
//    let gameDetailUseCase = Injection.init().provideGameDetail(id: game.id)
//    let presenter = GameDetailPresenter(gameDetailUseCase: gameDetailUseCase)
    return DetailView(presenter: presenter)
  }

}
