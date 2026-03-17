//
//  ContentView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI
import CorePackage
import Favorite
import Shared

struct ContentView: View {
  @EnvironmentObject var gamePresenter: GamePresenter
  @EnvironmentObject var favoritePresenter: GetListPresenter<
    Any,
    GameDomainModel,
    Interactor<
      Any,
      [GameDomainModel],
      FavoritesRepository<
        FavoritesLocaleDataSource,
        FavoriteTransformer
      >
    >
  >
  @EnvironmentObject var profilePresenter: ProfilePresenter
  
  var body: some View {
    TabView {
      GameView(presenter: gamePresenter)
        .tabItem {
          Label("Game", systemImage: "gamecontroller")
        }
      FavoriteView(presenter: favoritePresenter)
        .tabItem {
          Label("Favorite", systemImage: "heart.fill")
        }
      ProfileView(presenter: profilePresenter)
        .tabItem {
          Label("Profile", systemImage: "person.fill")
        }
    }
  }
}
