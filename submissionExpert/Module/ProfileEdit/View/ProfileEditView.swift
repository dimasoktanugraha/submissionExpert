//
//  ProfileEditView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 12/09/25.
//

import SwiftUI

struct ProfileEditView: View {
  
  @ObservedObject var presenter: ProfileEditPresenter
  @Environment(\.dismiss) var dismiss
  
  @State private var showAlert = false
  @State private var alertMessage = ""
  
  var body: some View {
    VStack(alignment: .leading) {
      Label("Name", systemImage: "person")
        .font(.subheadline)
        .padding(.horizontal, 16)
      TextField("Enter your name", text: $presenter.name)
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal, 16)
      Label("Job", systemImage: "briefcase")
        .font(.subheadline)
        .padding(.top, 20)
        .padding(.horizontal, 16)
      TextField("Enter your job", text: $presenter.job)
        .textFieldStyle(.roundedBorder)
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
      Button(action: validateUpdate) {
        Text("Update")
          .font(.subheadline)
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.black)
          .cornerRadius(12)
          .shadow(radius: 4)
      }
      .padding(.horizontal, 16)        }
    .padding()
    .alert(isPresented: $showAlert) {
      Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
    }
  }
  
  func validateUpdate() {
    if presenter.name.isEmpty {
      textEmpty("Name")
    } else if presenter.job.isEmpty {
      textEmpty("Email")
    } else {
      update()
    }
  }
  
  func update() {
    presenter.updateProfile()
    dismiss()
  }
  
  func textEmpty(_ field: String) {
    alertMessage = "\(field) is empty"
    showAlert = true
  }
}
