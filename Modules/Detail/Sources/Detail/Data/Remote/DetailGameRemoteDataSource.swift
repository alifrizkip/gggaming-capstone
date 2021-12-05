//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Combine
import Alamofire
import Foundation

import GGGamingCore
import Common

public struct DetailGameRemoteDataSource: DataSource {
  public typealias Request = Int
  public typealias Response = DetailGameResponse

  private let endpoint: String

  public init(endpoint: String) {
    self.endpoint = endpoint
  }

  public func execute(request: Int?) -> AnyPublisher<DetailGameResponse, Error> {
    return Future<DetailGameResponse, Error> { completion in
      let queryItems = API.defaultQueryItems

      var urlComponents = API.baseUrlComponents
      urlComponents.path = "\(endpoint)/\(request ?? 0)"
      urlComponents.queryItems = queryItems

      if let url = urlComponents.url {
        AF.request(url)
          .validate()
          .responseDecodable(of: DetailGameResponse.self) { response in
            switch response.result {
            case .success(let value): completion(.success(value))
            case .failure(_): completion(.failure(URLError.apiError))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
