//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//

import Combine

import GGGamingCore
import Common

public struct AddFavoriteRepository: Repository {
  public typealias Request = GameUIModel
  public typealias Response = Bool

  public func execute(request: GameUIModel?) -> AnyPublisher<Bool, Error> {
    let result = CoreDataService.shared.add(game: request!)
    return Future<Bool, Error> { completion in
      completion(.success(result))
    }.eraseToAnyPublisher()
  }
}
