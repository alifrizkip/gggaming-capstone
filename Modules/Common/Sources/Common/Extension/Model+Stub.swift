//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

extension GenreUIModel {
  public static var stub: GenreUIModel {
    return .init(id: 1, name: "Genre 1", slug: "genre-1")
  }
}

extension GameUIModel {
  public static var stub: GameUIModel {
    return .init(
      id: 1,
      name: "Sample Game",
      released: "1970-01-01",
      rating: 3,
      backgroundImage: API.defaultImageURL,
      description: "",
      descriptionRaw: "",
      genres: [.stub, .stub, .stub]
    )
  }
}

extension ScreenshotUIModel {
  public static var stub: ScreenshotUIModel {
    return .init(id: 1, image: API.defaultImageURL)
  }
}

extension ProfileUIModel {
  public static var stub: ProfileUIModel {
    return .init(name: "Test Name", email: "test@mail.com", githubUsername: "test", avatarName: "avatar")
  }
}
