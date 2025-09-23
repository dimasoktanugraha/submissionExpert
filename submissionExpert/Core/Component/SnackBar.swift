//
//  SnackBar.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 23/09/25.
//

import SwiftUI

struct SnackbarView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.red.opacity(0.9))
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.bottom, 20)
    }
}
