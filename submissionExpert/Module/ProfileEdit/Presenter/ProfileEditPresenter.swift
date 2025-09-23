//
//  ProfileEditViewModel.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 12/09/25.
//

import Foundation

class ProfileEditPresenter: ObservableObject {
  @Published var name: String = ""
  @Published var job: String = ""
  
  init() {
    self.name = ProfileModel.name
    self.job = ProfileModel.job
  }
  
  func updateProfile() {
    ProfileModel.name = name
    ProfileModel.job = job
  }
}
