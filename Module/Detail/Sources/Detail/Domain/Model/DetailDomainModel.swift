//
//  GameModel.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation

public struct DetailDomainModel: Equatable, Identifiable {

  public let id: Int
  public let name: String
  public let released: String
  public let backgroundImage: String
  public let rating: Double
  public let description: String
  
  public init(id: Int, name: String, released: String, backgroundImage: String, rating: Double, description: String) {
    self.id = id
    self.name = name
    self.released = released
    self.backgroundImage = backgroundImage
    self.rating = rating
    self.description = description
  }
}
