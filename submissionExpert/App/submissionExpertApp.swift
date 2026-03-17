//
//  submissionExpertApp.swift
//  submissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import SwiftUI
import CorePackage
import Shared
import Favorite

let favoriteUseCase: Interactor<
  Any,
  [GameDomainModel],
  FavoritesRepository<
    FavoritesLocaleDataSource,
    FavoriteTransformer>
> = Injection.init().provideFavorite()

@main
struct SubmissionExpertApp: App {
  
  let gamePresenter = GamePresenter(gameUseCase: Injection.init().provideGame())
  let profilePresenter = ProfilePresenter()
  
  let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
  
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environmentObject(gamePresenter)
              .environmentObject(favoritePresenter)
              .environmentObject(profilePresenter)
        }
    }
}
