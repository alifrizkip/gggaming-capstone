//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//  swiftlint:disable force_unwrapping

import Combine

import GGGamingCore
import Common

public struct CheckFavoriteRepository: Repository {
  public typealias Request = Int
  public typealias Response = Bool

  public func execute(request: Int?) -> AnyPublisher<Bool, Error> {
    let result = CoreDataService.shared.isExist(id: request!)
    return Future<Bool, Error> { completion in
      completion(.success(result))
    }.eraseToAnyPublisher()
  }
}
