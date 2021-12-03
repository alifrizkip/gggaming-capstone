import Common
import GGGamingCore

public struct ListFavoriteTransformer: Mapper {
  public typealias Response = [GameLocalEntity]
  public typealias Domain = [FavoriteGameModel]
  public typealias Presentation = [GameUIModel]

  public func transformResponseToDomain(response: [GameLocalEntity]) -> [FavoriteGameModel] {
    response.map { entity in
      let genres = entity.genres?
        .allObjects
        .map { genre -> FavoriteGenreModel? in
          guard let genre = genre as? GenreLocalEntity else { return nil }

          return FavoriteGenreModel(
            id: Int(genre.id),
            name: genre.name ?? "",
            slug: genre.slug ?? ""
          )
        }
        .compactMap { $0 }

      return FavoriteGameModel(
        id: Int(entity.id),
        name: entity.name ?? "",
        released: entity.released ?? "",
        rating: Int(entity.rating),
        backgroundImage: entity.backgroundImage ?? API.defaultImageURL,
        description: entity.descriptionString ?? "",
        descriptionRaw: entity.descriptionStringRaw ?? "",
        genres: genres ?? []
      )
    }
  }

  public func transformDomainToPresentation(domain: [FavoriteGameModel]) -> [GameUIModel] {
    domain.map { data in
      GameUIModel(
        id: data.id,
        name: data.name,
        released: data.released,
        rating: data.rating,
        backgroundImage: data.backgroundImage,
        description: data.description,
        descriptionRaw: data.descriptionRaw,
        genres: data.genres.map { genre in
          GenreUIModel(id: genre.id, name: genre.name, slug: genre.slug)
        }
      )
    }
  }
}
