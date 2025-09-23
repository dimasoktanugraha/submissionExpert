//
//  GameModel.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation

struct GameDetailModel: Equatable, Identifiable {

  let id: Int
  let name: String
  let released: String
  let backgroundImage: String
  let rating: Double
  let description: String
}
