//
//  GameItemView.swift
//  submissionpemula
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI
import CachedAsyncImage
import Shared

struct GameItemView: View {
  var game: GameDomainModel
  
  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      CachedAsyncImage(url: URL(string: game.backgroundImage)) { image in
         image.resizable()
       } placeholder: {
         ProgressView()
       }.scaledToFill()
        .frame(width: 100, height: 100, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .clipped()
      
      VStack(alignment: .leading, spacing: 4) {
        Text(game.name)
          .font(.system(size: 16))
          .fontWeight(.medium)
        Spacer()
        HStack {
          Text(game.released)
            .font(.system(size: 14))
            .foregroundColor(Color.gray)
          Spacer()
          HStack {
            Image(systemName: "star.fill")
              .frame(width: 12, height: 12)
              .foregroundColor(Color.yellow)
            Text(String(game.rating))
              .font(.system(size: 14))
              .foregroundColor(Color.gray)
          }
        }
      }
      Spacer()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12, style: .continuous)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    )
    .contentShape(Rectangle())
  }
}
