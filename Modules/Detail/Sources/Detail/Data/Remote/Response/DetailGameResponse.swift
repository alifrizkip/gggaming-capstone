//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

public struct DetailGameResponse: Codable {
  let id: Int
  let name: String
  let released: String?
  let rating: Double
  let backgroundImage: String?
  let description: String
  let descriptionRaw: String
  let genres: [GenreResponse]

  private enum CodingKeys: String, CodingKey {
    case id, name, released, rating, description, genres
    case backgroundImage = "background_image"
    case descriptionRaw = "description_raw"
  }
}

public struct GenreResponse: Codable {
  let id: Int
  let name: String
  let slug: String
}
