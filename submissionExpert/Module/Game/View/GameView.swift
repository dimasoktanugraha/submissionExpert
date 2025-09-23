//
//  GameView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 11/09/25.
//

import SwiftUI

struct GameView: View {
  
  @ObservedObject var presenter: GamePresenter
  
  var body: some View {
    NavigationStack {
      ZStack {
        if presenter.loadingState {
          VStack {
            ProgressView("Loading...")
              .progressViewStyle(CircularProgressViewStyle())
              .padding()
          }
        } else if presenter.games.isEmpty {
          VStack {
            Text("There is no game")
              .padding()
          }
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.games,
              id: \.id
            ) { game in
              ZStack {
                self.presenter.linkBuilder(for: game) {
                  GameItemView(game: game)
                }.buttonStyle(PlainButtonStyle())
              }.padding(8)
            }
          }
        }
        
        if !presenter.errorMessage.isEmpty {
          VStack {
            Spacer()
            SnackbarView(message: presenter.errorMessage)
              .transition(.move(edge: .bottom).combined(with: .opacity))
              .animation(.easeInOut, value: !presenter.errorMessage.isEmpty)
          }
        }
      }
      .navigationBarTitle(
            Text("Games"),
            displayMode: .automatic
          )
      .searchable(text: $presenter.searchText, prompt: "Search games")
      .onAppear {
        presenter.getGames(query: "")
      }
      .onChange(of: presenter.errorMessage) {
        if !presenter.errorMessage.isEmpty {
          DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            presenter.errorMessage = ""
          }
        }
      }
    }
  }
}
