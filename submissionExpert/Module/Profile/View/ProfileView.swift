//
//  ProfileView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI

struct ProfileView: View {
  
  @ObservedObject var presenter: ProfilePresenter
  
  var body: some View {
    NavigationStack {
      Group {
        VStack(alignment: .center) {
          Image("profile")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .overlay(
              Circle().stroke(Color.black, lineWidth: 5)
            )
          
          Text(presenter.name)
            .font(.system(size: 20))
            .fontWeight(.medium)
            .padding(.bottom, 5)
            .padding(.top, 20)
          
          Text(presenter.job)
            .font(.system(size: 16))
            .padding(.bottom, 10)
          
          Spacer()
        }
      }
      .navigationTitle("Profile")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          self.presenter.linkBuilder {
            Image(systemName: "pencil.circle")
              .foregroundColor(Color.black)
          }
        }
      }
      .onAppear {
        presenter.getProfile()
      }
    }
  }
}
