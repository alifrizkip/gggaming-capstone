//
//  SearchTransformer.swift
//  Search
//
//  Created by alip on 30/11/21.
//

import Common
import GGGamingCore

public struct DetailTransformer: Mapper {
  public typealias Response = DetailGameResponse
  public typealias Domain = DetailGameModel
  public typealias Presentation = GameUIModel

  public func transformResponseToDomain(response: DetailGameResponse) -> DetailGameModel {
    return DetailGameModel(
      id: response.id,
      name: response.name,
      released: Helpers.convertGameReleasedText(response.released),
      rating: Int(response.rating.rounded()),
      backgroundImage: response.backgroundImage ?? API.defaultImageURL,
      description: response.description,
      descriptionRaw: response.descriptionRaw,
      genres: response.genres.map { genreResp in
        return DetailGameGenreModel(
          id: genreResp.id,
          name: genreResp.name,
          slug: genreResp.slug
        )
      }
    )
  }

  public func transformDomainToPresentation(domain: DetailGameModel) -> GameUIModel {
    return GameUIModel(
      id: domain.id,
      name: domain.name,
      released: domain.released,
      rating: domain.rating,
      backgroundImage: domain.backgroundImage,
      description: domain.description,
      descriptionRaw: domain.descriptionRaw,
      genres: domain.genres.map { genreModel in
        return GenreUIModel(
          id: genreModel.id,
          name: genreModel.name,
          slug: genreModel.slug
        )
      }
    )
  }
}
