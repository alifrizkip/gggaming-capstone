//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Common
import GGGamingCore
import Combine

public struct HomeRepository<
  ListRemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository
where ListRemoteDataSource.Request == String,
  ListRemoteDataSource.Response == [GameResponse],
  Transformer.Response == [GameResponse],
  Transformer.Domain == [GameModel],
  Transformer.Presentation == [GameUIModel] {
  public typealias Request = String
  public typealias Response = [GameUIModel]

  private let remote: ListRemoteDataSource
  private let mapper: Transformer

  public init(remote: ListRemoteDataSource, mapper: Transformer) {
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
