//
//  ProfileViewModel.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 12/09/25.
//

import SwiftUI

class ProfilePresenter: ObservableObject {
  
  private let router = ProfileRouter()
  
  @Published var name: String = ""
  @Published var job: String = ""
  
  init() {
    getProfile()
  }
  
  func getProfile() {
    self.name = ProfileModel.name
    self.job = ProfileModel.job
  }
  
  func linkBuilder<Content: View>(
   @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeProfileEditView()) { content() }
  }
}
