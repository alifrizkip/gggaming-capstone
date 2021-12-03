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
  GetScreenshotsRemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository
where GetScreenshotsRemoteDataSource.Request == Int,
      GetScreenshotsRemoteDataSource.Response == [ScreenshotResponse],
      Transformer.Response == [ScreenshotResponse],
      Transformer.Domain == [ScreenshotModel],
      Transformer.Presentation == [ScreenshotUIModel] {

  public typealias Request = Int
  public typealias Response = [ScreenshotUIModel]

  private let remote: GetScreenshotsRemoteDataSource
  private let mapper: Transformer

  public init(remote: GetScreenshotsRemoteDataSource, mapper: Transformer) {
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
