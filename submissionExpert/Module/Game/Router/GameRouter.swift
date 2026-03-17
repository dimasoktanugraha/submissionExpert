//
//  GameRouter.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import SwiftUI
import CorePackage
import Detail
import Shared
import Favorite

class GameRouter {

  @MainActor
  func makeDetailView(for gameId: Int) -> some View {

    guard let detailUseCase: Interactor<
      Any,
      DetailDomainModel,
      GetDetailRepository<
        GetDetailRemoteDataSource,
        DetailTransformer>
    > = Injection.init().provideDetail(id: gameId) else {
        fatalError("Failed to create detail use case")
    }
    
    let favoriteUseCase: FavoriteInteractor = Injection().provideFavoriteDetail()
    
    let presenter = DetailPresenter(detailUseCase: detailUseCase, favoriteUseCase: favoriteUseCase)
    
    return DetailView(presenter: presenter)
  }
}
