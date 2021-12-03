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
    case .apiError: return "Failed get data"
    case .noData: return "No data"
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    case .invalidEndpoint: return "Bad request"
    case .operationFailed: return "Operation failed"
    }
  }
}

public enum DatabaseError: LocalizedError {
  case operationFailed
  case noData

  public var errorDescription: String? {
    switch self {
    case .operationFailed: return "Operation failed"
    case .noData: return "No data"
    }
  }
}
