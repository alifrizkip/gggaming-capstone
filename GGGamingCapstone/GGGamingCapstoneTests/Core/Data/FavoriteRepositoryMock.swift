//
//  FavoriteRepositoryMock.swift
//  GGGamingCapstoneTests
//
//  Created by alip on 17/11/21.
//

import Combine
import Common
@testable import GGGamingCapstone

class FavoriteRepositoryMock: FavoriteRepositoryProtocol {
  var isHasBeenCalled = false

  init() {
    isHasBeenCalled = false
  }

  func getGames() -> AnyPublisher<[GameUIModel], Error> {
    return Future<[GameUIModel], Error> { completion in
      completion(.success([.stub, .stub]))
    }.eraseToAnyPublisher()
  }

  func isFavorite(id: Int) -> Bool {
    true
  }

  func add(game: GameUIModel) {
    isHasBeenCalled = true
  }

  func delete(id: Int) {
    isHasBeenCalled = true
  }
}
