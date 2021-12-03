//
//  FavoriteInteractorTest.swift
//  GGGamingCapstoneTests
//
//  Created by alip on 17/11/21.
//

import XCTest
import Combine
import Common
@testable import GGGamingCapstone

class FavoriteInteractorTest: XCTestCase {
  private var cancellables: Set<AnyCancellable> = []

  func test_getGames() {
    let repo = FavoriteRepositoryMock()
    let useCase = FavoriteInteractor(repository: repo)

    let expectation = self.expectation(description: "FavoriteInteractor.getGames")
    let expected: [GameUIModel] = [.stub, .stub]
    var error: Error?
    var result: [GameUIModel] = []

    useCase.getGames()
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished: break
        case .failure(let err): error = err
        }

        expectation.fulfill()
      }, receiveValue: { games in
        result = games
      })
      .store(in: &cancellables)
    waitForExpectations(timeout: 10)

    XCTAssertNil(error)
    XCTAssertEqual(result.count, expected.count)
    XCTAssertEqual(result[0].id, expected[0].id)
  }
}
