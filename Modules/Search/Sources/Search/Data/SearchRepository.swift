//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Common
import GGGamingCore
import Combine

public struct SearchRepository<
  SearchRemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository
where SearchRemoteDataSource.Request == String,
      SearchRemoteDataSource.Response == [SearchGameResponse],
      Transformer.Response == [SearchGameResponse],
      Transformer.Domain == [SearchGameModel],
      Transformer.Presentation == [GameUIModel] {
  public typealias Request = String
  public typealias Response = [GameUIModel]

  private let remote: SearchRemoteDataSource
  private let mapper: Transformer

  public init(remote: SearchRemoteDataSource, mapper: Transformer) {
    self.remote = remote
    self.mapper = mapper
  }

  public func execute(request: String?) -> AnyPublisher<[GameUIModel], Error> {
    remote.execute(request: request)
      .map { mapper.transformResponseToDomain(response: $0) }
      .map { mapper.transformDomainToPresentation(domain: $0) }
      .eraseToAnyPublisher()
  }
}
