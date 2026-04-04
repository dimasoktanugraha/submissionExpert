//
//  FavoriteView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 11/09/25.
//

import SwiftUI
import CorePackage
import Shared
import Favorite

struct FavoriteView: View {
  @ObservedObject var presenter: GetListPresenter<
    Any,
    GameDomainModel,
    Interactor<Any, [GameDomainModel], FavoritesRepository<FavoritesLocaleDataSource, FavoriteTransformer>>>
  
  private let router = GameRouter()
  
  var body: some View {
    NavigationStack {
      ZStack {
        if presenter.isLoading {
          loadingView
        } else if presenter.isError {
          errorView
        } else if presenter.list.isEmpty {
          emptyView
        } else {
          contentView
        }
      }
      .navigationBarTitle(
            Text("Favorite Games"),
            displayMode: .automatic
          )
      .onAppear {
        print("🟢 Calling presenter.getList()")
        Task {
          presenter.getList(request: nil)
        }
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

private extension FavoriteView {

    var loadingView: some View {
        VStack {
            ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        }
    }

    var errorView: some View {
        VStack {
            Spacer()
            SnackbarView(message: presenter.errorMessage)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: !presenter.errorMessage.isEmpty)
        }
    }

    var emptyView: some View {
        VStack {
            Text("There is no game")
                .padding()
        }
    }

    var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
          ForEach(
            presenter.list,
            id: \.id
          ) { game in
            ZStack {
              NavigationLink(
                destination: router.makeDetailView(for: game.id)
              ) {
                GameItemView(game: game)
              }
            }.padding(8)
          }
        }
        .overlay(errorSnackbarOverlay)
    }

    var errorSnackbarOverlay: some View {
        Group {
            if !presenter.errorMessage.isEmpty {
                VStack {
                    Spacer()
                    SnackbarView(message: presenter.errorMessage)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut, value: !presenter.errorMessage.isEmpty)
                }
            }
        }
    }
}
