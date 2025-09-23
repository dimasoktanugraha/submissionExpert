//
//  GameDetailResponse.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation

struct GameDetailResponse: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let description: String?

    enum CodingKeys: String, CodingKey {
      case id, name, released, rating, description
      case backgroundImage = "background_image"
    }
}
