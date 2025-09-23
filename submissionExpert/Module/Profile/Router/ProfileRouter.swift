//
//  ProfileRouter.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import SwiftUI

class ProfileRouter {

  func makeProfileEditView() -> some View {
    let presenter = ProfileEditPresenter()
    return ProfileEditView(presenter: presenter)
  }

}
