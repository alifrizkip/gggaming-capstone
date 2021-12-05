//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//

import Combine

import GGGamingCore
import Common

public struct ListFavoriteRepository<
  Transformer: Mapper
>: Repository
where Transformer.Response == [GameLocalEntity],
  Transformer.Domain == [FavoriteGameModel],
  Transformer.Presentation == [GameUIModel] {
  public typealias Request = String
  public typealias Response = [GameUIModel]

  private let mapper: Transformer

  public init(mapper: Transformer) {
    self.mapper = mapper
  }

  public func execute(request: String?) -> AnyPublisher<[GameUIModel], Error> {
    return CoreDataService.shared.fetchAll()
      .map { mapper.transformResponseToDomain(response: $0) }
      .map { mapper.transformDomainToPresentation(domain: $0) }
      .eraseToAnyPublisher()
  }
}
