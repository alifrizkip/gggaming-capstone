//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import Foundation

public enum URLError: LocalizedError {
  case apiError
  case noData
  case invalidEndpoint
  case operationFailed
  case addressUnreachable(URL)

  public var errorDescription: String? {
    switch self {
    case .apiError: return "failed_get_data".toLocalized()
    case .noData: return "no_data".toLocalized()
    case .addressUnreachable(let url):
      return "\(url.absoluteString) \("is_unreachable".toLocalized())"
    case .invalidEndpoint: return "bad_request".toLocalized()
    case .operationFailed: return "operation_failed".toLocalized()
    }
  }
}

public enum DatabaseError: LocalizedError {
  case operationFailed
  case noData

  public var errorDescription: String? {
    switch self {
    case .operationFailed: return "operation_failed".toLocalized()
    case .noData: return "no_data".toLocalized()
    }
  }
}
