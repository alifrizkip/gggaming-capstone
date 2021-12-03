//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

public struct SearchGameResponse: Codable {
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

public struct SearchGamesListResponse: Codable {
  let results: [SearchGameResponse]
}

public struct GenreResponse: Codable {
  let id: Int
  let name: String
  let slug: String
}
