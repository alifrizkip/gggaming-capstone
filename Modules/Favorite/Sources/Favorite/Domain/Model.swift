//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//

public struct FavoriteGameModel: Identifiable {
  public let id: Int
  public let name: String
  public let released: String
  public let rating: Int
  public let backgroundImage: String
  public let description: String
  public let descriptionRaw: String
  public let genres: [FavoriteGenreModel]
}

public struct FavoriteGenreModel: Identifiable {
  public let id: Int
  public let name: String
  public let slug: String
}
