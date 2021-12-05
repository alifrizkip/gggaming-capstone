//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//

import Common
import GGGamingCore

public struct ScreenshotTransformer: Mapper {
  public typealias Response = [ScreenshotResponse]
  public typealias Domain = [ScreenshotModel]
  public typealias Presentation = [ScreenshotUIModel]

  public func transformResponseToDomain(response: [ScreenshotResponse]) -> [ScreenshotModel] {
    response.map { ScreenshotModel(id: $0.id, image: $0.image) }
  }

  public func transformDomainToPresentation(domain: [ScreenshotModel]) -> [ScreenshotUIModel] {
    domain.map { ScreenshotUIModel(id: $0.id, image: $0.image) }
  }
}
