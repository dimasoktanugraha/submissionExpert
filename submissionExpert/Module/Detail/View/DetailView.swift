//
//  DetailView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI
import CachedAsyncImage
import CorePackage
import Detail

struct DetailView: View {
  
  @ObservedObject var presenter: DetailPresenter
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingView
      } else if presenter.isError {
        errorView
      } else if presenter.game == nil {
        emptyView
      } else {
        contentView
      }
    }
    .onAppear {
        print("🟢 Calling presenter.getById()")
        presenter.getGameDetail()
    }
    .navigationTitle("Detail")
    .navigationBarTitleDisplayMode(.inline)
  }
}

private extension DetailView {

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
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                gameImage
                gameTitle
                gameInfo
                gameDescription
                Spacer()
            }
            .padding(20)
            .overlay(errorSnackbarOverlay)
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { favoriteButton }
        .onChange(of: presenter.errorMessage) {
            if !presenter.errorMessage.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    presenter.errorMessage = ""
                }
            }
        }
    }

    var gameImage: some View {
        CachedAsyncImage(url: URL(string: presenter.game?.backgroundImage ?? "")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFill()
        .frame(width: 300, height: 300, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .clipped()
    }

    var gameTitle: some View {
        Text(presenter.game?.name ?? "")
            .font(.title2)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(.vertical, 10)
    }

    var gameInfo: some View {
        HStack {
            Image(systemName: "calendar.badge.plus")
            Text(presenter.game?.released ?? "")
                .font(.subheadline)
            Spacer()
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(String(presenter.game?.rating ?? 0.0))
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.yellow)
        }
        .padding(.horizontal)
    }

    var gameDescription: some View {
        HTMLTextView(html: presenter.game?.description ?? "No description available")
    }

    var favoriteButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              presenter.toggleFavorite()
            }
            ){
                Image(systemName: presenter.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(presenter.isFavorite ? .red : .black)
            }
        }
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
