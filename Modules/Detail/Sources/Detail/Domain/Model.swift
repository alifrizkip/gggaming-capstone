//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

public struct DetailGameModel: Identifiable {
  public let id: Int
  public let name: String
  public let released: String
  public let rating: Int
  public let backgroundImage: String
  public let description: String
  public let descriptionRaw: String
  public let genres: [DetailGameGenreModel]
}

public struct DetailGameGenreModel: Identifiable {
  public let id: Int
  public let name: String
  public let slug: String
}

public struct ScreenshotModel: Identifiable {
  public let id: Int
  public let image: String
}
