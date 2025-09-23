//
//  DetailView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI
import CachedAsyncImage

struct DetailView: View {
  
  @ObservedObject var presenter: GameDetailPresenter
  
  var body: some View {
    ZStack {
      if presenter.loadingState {
        VStack {
          ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
        }
      } else if presenter.game == nil {
        VStack {
          Text("There is no game")
            .padding()
        }
      } else {
        ScrollView {
          VStack(alignment: .center, spacing: 16) {
            
            // Game image
            CachedAsyncImage(url: URL(string: presenter.game?.backgroundImage ?? "")) { image in
               image.resizable()
             } placeholder: {
               ProgressView()
             }.scaledToFill()
              .frame(width: 300, height: 300, alignment: .center)
              .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
              .clipped()
            
            // Game title
            Text(presenter.game?.name ?? "")
              .font(.title2)
              .fontWeight(.medium)
              .multilineTextAlignment(.center)
              .padding(.vertical, 10)
            
            // Release date & rating
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
            
            // Description
            HTMLTextView(html: presenter.game?.description ?? "No description available")
            
            Spacer()
          }
          .padding(20)
          
          if !presenter.errorMessage.isEmpty {
            VStack {
              Spacer()
              SnackbarView(message: presenter.errorMessage)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: !presenter.errorMessage.isEmpty)
            }
          }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
              presenter.toggleFavorite()
            }, label: {
              Image(systemName: presenter.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(presenter.isFavorite ? .red : .black)
            })
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
}
