//
//  GameResponse.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation

struct GamesResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameResponse]
}

struct GameResponse: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
    }
}
