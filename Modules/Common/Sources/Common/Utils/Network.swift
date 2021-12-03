//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Foundation

public enum API {
  public static let baseURL = "https://api.rawg.io/api/games"
  public static let apiKey = "bb97952fd5494c1da90bb6a810df6002"
  public static let defaultImageURL = "https://dicoding-ios-app-pemula-api.web.app/images/default-image.png"
  public static let defaultQueryParams = "page_size=8&ordering=-rating&search_precise=true&key=\(API.apiKey)"

  public static var defaultQueryItems: [URLQueryItem] {
    return [
      URLQueryItem(name: "page_size", value: "8"),
      URLQueryItem(name: "ordering", value: "-rating"),
      URLQueryItem(name: "search_precise", value: "true"),
      URLQueryItem(name: "key", value: API.apiKey)
    ]
  }

  public static var baseUrlComponents: URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.rawg.io"

    return urlComponents
  }
}
