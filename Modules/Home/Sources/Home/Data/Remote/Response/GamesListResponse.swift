//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

public struct GameResponse: Codable {
  let id: Int
  let name: String
  let released: String?
  let rating: Double
  let backgroundImage: String?
  let genres: [GenreResponse]

  private enum CodingKeys: String, CodingKey {
    case id, name, released, rating, genres
    case backgroundImage = "background_image"
  }
}

public struct GenreResponse: Codable {
  let id: Int
  let name: String
  let slug: String
}

public struct GamesListResponse: Codable {
  let results: [GameResponse]
}
