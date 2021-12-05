//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//

import Combine
import Alamofire
import Foundation

import GGGamingCore
import Common

public struct ScreenshotRemoteDataSource: DataSource {
  public typealias Request = Int
  public typealias Response = [ScreenshotResponse]

  private let endpoint: String

  public init(endpoint: String) {
    self.endpoint = endpoint
  }

  public func execute(request: Int?) -> AnyPublisher<[ScreenshotResponse], Error> {
    return Future<[ScreenshotResponse], Error> { completion in
      let queryItems = API.defaultQueryItems

      var urlComponents = API.baseUrlComponents
      urlComponents.path = "\(endpoint)/\(request ?? 0)/screenshots"
      urlComponents.queryItems = queryItems

      if let url = urlComponents.url {
        AF.request(url)
          .validate()
          .responseDecodable(of: ScreenshotsListResponse.self) { response in
            switch response.result {
            case .success(let value): completion(.success(value.results))
            case .failure(_): completion(.failure(URLError.apiError))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
