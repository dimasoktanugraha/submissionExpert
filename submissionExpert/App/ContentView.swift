//
//  ContentView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var gamePresenter: GamePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
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

#Preview {
  ContentView()
    .environmentObject(GamePresenter(gameUseCase: Injection.init().provideGame()))
    .environmentObject(FavoritePresenter(favoriteUseCase: Injection.init().provideFavoriteGame()))
    .environmentObject(ProfilePresenter())
}
