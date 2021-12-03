//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Combine

import GGGamingCore
import Common

public struct GetDetailRepository<
  GetDetailRemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository
where GetDetailRemoteDataSource.Request == Int,
      GetDetailRemoteDataSource.Response == DetailGameResponse,
      Transformer.Response == DetailGameResponse,
      Transformer.Domain == DetailGameModel,
      Transformer.Presentation == GameUIModel {

  public typealias Request = Int
  public typealias Response = GameUIModel

  private let remote: GetDetailRemoteDataSource
  private let mapper: Transformer

  public init(remote: GetDetailRemoteDataSource, mapper: Transformer) {
    self.remote = remote
    self.mapper = mapper
  }

  public func execute(request: Int?) -> AnyPublisher<GameUIModel, Error> {
    remote.execute(request: request)
      .map { mapper.transformResponseToDomain(response: $0) }
      .map { mapper.transformDomainToPresentation(domain: $0) }
      .eraseToAnyPublisher()
  }
}
