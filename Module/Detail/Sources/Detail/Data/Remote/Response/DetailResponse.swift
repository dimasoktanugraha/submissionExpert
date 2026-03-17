//
//  DetailResponse.swift
//  Detail
//
//  Created by Dimas Oktanugraha on 05/10/25.
//

import Foundation

public struct DetailResponse: Decodable, Sendable {

  private enum CodingKeys: String, CodingKey {
    case id, name, released, rating, description
    case backgroundImage = "background_image"
  }

  let id: Int?
  let name: String?
  let released: String?
  let backgroundImage: String?
  let rating: Double?
  let description: String?
}
