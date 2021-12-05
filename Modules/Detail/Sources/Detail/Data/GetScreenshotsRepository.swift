//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//

import Combine

import GGGamingCore
import Common

public struct GetScreenshotsRepository<
  GetSSRemoteDS: DataSource,
  Transformer: Mapper
>: Repository
where GetSSRemoteDS.Request == Int,
  GetSSRemoteDS.Response == [ScreenshotResponse],
  Transformer.Response == [ScreenshotResponse],
  Transformer.Domain == [ScreenshotModel],
  Transformer.Presentation == [ScreenshotUIModel] {
  public typealias Request = Int
  public typealias Response = [ScreenshotUIModel]

  private let remote: GetSSRemoteDS
  private let mapper: Transformer

  public init(remote: GetSSRemoteDS, mapper: Transformer) {
    self.remote = remote
    self.mapper = mapper
  }

  public func execute(request: Int?) -> AnyPublisher<[ScreenshotUIModel], Error> {
    remote.execute(request: request)
      .map { mapper.transformResponseToDomain(response: $0) }
      .map { mapper.transformDomainToPresentation(domain: $0) }
      .eraseToAnyPublisher()
  }
}
