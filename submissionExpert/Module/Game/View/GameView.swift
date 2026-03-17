//
//  GameView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 11/09/25.

import SwiftUI

@MainActor
struct GameView: View {
    @ObservedObject var presenter: GamePresenter

    var body: some View {
        NavigationStack {
            ZStack {
                contentView

                if !presenter.errorMessage.isEmpty {
                    errorSnackbar
                }
            }
            .navigationBarTitle(Text("Games"), displayMode: .automatic)
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

private extension GameView {
    @ViewBuilder
    var contentView: some View {
        if presenter.loadingState {
            loadingView
        } else if presenter.games.isEmpty {
            emptyView
        } else {
            gameList
        }
    }

    var loadingView: some View {
        VStack {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        }
    }

    var emptyView: some View {
        VStack {
            Text("There is no game")
                .padding()
        }
    }

    var gameList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(presenter.games, id: \.id) { game in
                    presenter.linkBuilder(for: game) {
                        GameItemView(game: game)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                }
            }
        }
    }

    var errorSnackbar: some View {
        VStack {
            Spacer()
            SnackbarView(message: presenter.errorMessage)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: !presenter.errorMessage.isEmpty)
        }
    }
}
