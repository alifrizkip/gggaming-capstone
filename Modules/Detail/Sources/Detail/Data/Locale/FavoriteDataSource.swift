//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//

import Combine

import GGGamingCore
import Common

public struct FavoriteDataSource: LocaleDataSource {
  public typealias Request = GameUIModel
  public typealias Response = GameLocalEntity

  public init() {}

  public func list() -> AnyPublisher<[GameLocalEntity], Error> {
    CoreDataService.shared.fetchAll()
  }

  public func get(id: Int) -> AnyPublisher<GameLocalEntity, Error> {
    fatalError("not implemented")
  }

  public func isExist(id: Int) -> AnyPublisher<Bool, Error> {
    let result = CoreDataService.shared.isExist(id: id)
    return Future<Bool, Error> { completion in
      completion(.success(result))
    }
    .eraseToAnyPublisher()
  }

  public func add(entity: GameUIModel) -> AnyPublisher<Bool, Error> {
    let result = CoreDataService.shared.add(game: entity)
    return Future<Bool, Error> { completion in
      completion(.success(result))
    }
    .eraseToAnyPublisher()
  }

  public func delete(id: Int) -> AnyPublisher<Bool, Error> {
    let result = CoreDataService.shared.delete(id: id)
    return Future<Bool, Error> { completion in
      completion(.success(result))
    }
    .eraseToAnyPublisher()
  }
}
