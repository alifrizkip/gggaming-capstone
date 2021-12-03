//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Common
import GGGamingCore

public struct HomeTransformer: Mapper {
  public typealias Response = [GameResponse]
  public typealias Domain = [GameModel]
  public typealias Presentation = [GameUIModel]

  public func transformResponseToDomain(response: [GameResponse]) -> [GameModel] {
    return response.map { gameResp in
      return GameModel(
        id: gameResp.id,
        name: gameResp.name,
        released: Helpers.convertGameReleasedText(gameResp.released),
        rating: Int(gameResp.rating.rounded()),
        backgroundImage: gameResp.backgroundImage ?? API.defaultImageURL,
        description: "",
        descriptionRaw: "",
        genres: gameResp.genres.map { genreResp in
          return GameGenreModel(
            id: genreResp.id,
            name: genreResp.name,
            slug: genreResp.slug
          )
        }
      )
    }
  }

  public func transformDomainToPresentation(domain: [GameModel]) -> [GameUIModel] {
    return domain.map { gameModel in
      return GameUIModel(
        id: gameModel.id,
        name: gameModel.name,
        released: gameModel.released,
        rating: gameModel.rating,
        backgroundImage: gameModel.backgroundImage,
        description: gameModel.description,
        descriptionRaw: gameModel.descriptionRaw,
        genres: gameModel.genres.map { genreModel in
          return GenreUIModel(
            id: genreModel.id,
            name: genreModel.name,
            slug: genreModel.slug
          )
        }
      )
    }
  }
}
