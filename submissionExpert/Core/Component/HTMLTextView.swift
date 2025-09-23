//
//  HTMLTextView.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 10/09/25.
//

import SwiftUI

struct HTMLTextView: View {
  let html: String
  
  private var attributedString: AttributedString? {
    guard let data = html.data(using: .utf8) else { return nil }
    do {
      let nsAttr = try NSAttributedString(
        data: data,
        options: [
          .documentType: NSAttributedString.DocumentType.html,
          .characterEncoding: String.Encoding.utf8.rawValue
        ],
        documentAttributes: nil
      )
      return AttributedString(nsAttr)
    } catch {
      print("HTML parsing error: \(error)")
      return nil
    }
  }
  
  var body: some View {
    if let attributedString = attributedString {
      Text(attributedString)
        .lineLimit(nil)
        .fixedSize(horizontal: false, vertical: true)
        .font(.caption)
        .foregroundColor(.gray)
        .padding(.top, 20)
    } else {
      Text("⚠️ Failed to render HTML")
        .foregroundColor(.red)
    }
  }
}
