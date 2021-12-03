//
//  SearchTransformer.swift
//  Search
//
//  Created by alip on 30/11/21.
//

import Common
import GGGamingCore

public struct SearchTransformer: Mapper {
  public typealias Response = [SearchGameResponse]
  public typealias Domain = [SearchGameModel]
  public typealias Presentation = [GameUIModel]

  public func transformResponseToDomain(response: [SearchGameResponse]) -> [SearchGameModel] {
    return response.map { gameResp in
      return SearchGameModel(
        id: gameResp.id,
        name: gameResp.name,
        released: Helpers.convertGameReleasedText(gameResp.released),
        rating: Int(gameResp.rating.rounded()),
        backgroundImage: gameResp.backgroundImage ?? API.defaultImageURL,
        description: "",
        descriptionRaw: "",
        genres: gameResp.genres.map { genreResp in
          return SearchGameGenreModel(
            id: genreResp.id,
            name: genreResp.name,
            slug: genreResp.slug
          )
        }
      )
    }
  }

  public func transformDomainToPresentation(domain: [SearchGameModel]) -> [GameUIModel] {
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
