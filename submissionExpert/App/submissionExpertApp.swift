//
//  submissionExpertApp.swift
//  submissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import SwiftUI

@main
struct SubmissionExpertApp: App {
  
  let gamePresenter = GamePresenter(gameUseCase: Injection.init().provideGame())
  let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.init().provideFavoriteGame())
  let profilePresenter = ProfilePresenter()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environmentObject(gamePresenter)
              .environmentObject(favoritePresenter)
              .environmentObject(profilePresenter)
        }
    }
}
