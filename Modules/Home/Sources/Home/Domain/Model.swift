//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

public struct GameModel: Identifiable {
  public let id: Int
  public let name: String
  public let released: String
  public let rating: Int
  public let backgroundImage: String
  public let description: String
  public let descriptionRaw: String
  public let genres: [GameGenreModel]
}

public struct GameGenreModel: Identifiable {
  public let id: Int
  public let name: String
  public let slug: String
}
