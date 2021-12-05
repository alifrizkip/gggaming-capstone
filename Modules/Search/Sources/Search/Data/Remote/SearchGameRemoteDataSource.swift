//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Common
import GGGamingCore
import Combine
import Alamofire
import Foundation

public struct SearchGameRemoteDataSource: DataSource {
  public typealias Request = String
  public typealias Response = [SearchGameResponse]

  private let endpoint: String

  public init(endpoint: String) {
    self.endpoint = endpoint
  }

  public func execute(request: String?) -> AnyPublisher<[SearchGameResponse], Error> {
    return Future<[SearchGameResponse], Error> { completion in
      var queryItems = API.defaultQueryItems
      queryItems.append(URLQueryItem(name: "search", value: request ?? ""))

      var urlComponents = API.baseUrlComponents
      urlComponents.path = endpoint
      urlComponents.queryItems = queryItems

      if let url = urlComponents.url {
        AF.request(url)
          .validate()
          .responseDecodable(of: SearchGamesListResponse.self) { response in
            switch response.result {
            case .success(let value): completion(.success(value.results))
            case .failure(_): completion(.failure(URLError.apiError))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
