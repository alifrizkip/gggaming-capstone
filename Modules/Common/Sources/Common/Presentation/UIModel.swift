//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

public struct GameUIModel: Identifiable {
  public let id: Int
  public let name: String
  public let released: String
  public let rating: Int
  public let backgroundImage: String
  public let description: String
  public let descriptionRaw: String
  public let genres: [GenreUIModel]

  public init(id: Int, name: String, released: String, rating: Int, backgroundImage: String, description: String, descriptionRaw: String, genres: [GenreUIModel]) {
    self.id = id
    self.name = name
    self.released = released
    self.rating = rating
    self.backgroundImage = backgroundImage
    self.description = description
    self.descriptionRaw = descriptionRaw
    self.genres = genres
  }
}

public struct GenreUIModel: Identifiable {
  public let id: Int
  public let name: String
  public let slug: String

  public init(id: Int, name: String, slug: String) {
    self.id = id
    self.name = name
    self.slug = slug
  }
}

public struct ScreenshotUIModel: Identifiable {
  public let id: Int
  public let image: String

  public init(id: Int, image: String) {
    self.id = id
    self.image = image
  }
}

public struct ProfileUIModel {
  public let name: String
  public let email: String
  public let githubUsername: String
  public let avatarName: String

  public init(name: String, email: String, githubUsername: String, avatarName: String) {
    self.name = name
    self.email = email
    self.githubUsername = githubUsername
    self.avatarName = avatarName
  }
}
