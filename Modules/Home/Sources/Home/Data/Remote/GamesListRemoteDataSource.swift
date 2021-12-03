//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Common
import GGGamingCore
import Combine
import Alamofire
import Foundation

public struct GamesListRemoteDataSource : DataSource {
  public typealias Request = String
  public typealias Response = [GameResponse]

  private let endpoint: String

  public init(endpoint: String) {
    self.endpoint = endpoint
  }

  public func execute(request: String?) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      var queryItems = API.defaultQueryItems
      queryItems.append(URLQueryItem(name: "genres", value: request ?? ""))

      var urlComponents = API.baseUrlComponents
      urlComponents.path = endpoint
      urlComponents.queryItems = queryItems

      if let url = urlComponents.url {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesListResponse.self) { response in
            switch response.result {
            case .success(let value): completion(.success(value.results))
            case .failure(_): completion(.failure(URLError.apiError))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}

