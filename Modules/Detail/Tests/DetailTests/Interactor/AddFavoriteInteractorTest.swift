//
//  File.swift
//  
//
//  Created by alip on 05/12/21.
//

import XCTest
import Combine

import GGGamingCore
import Common
@testable import Detail

final class AddFavoriteInteractorTest: XCTestCase {
  private var cancellables: Set<AnyCancellable> = []

  func test_returnSuccessTrue() {
    // setup
    let repo = RepositoryMock<GameUIModel, Bool>(data: true)
    let useCase = Interactor<
      GameUIModel,
      Bool,
      RepositoryMock<GameUIModel, Bool>
    >(repository: repo)

    // prepare
    let expectation = self.expectation(description: "should return success (no error)")
    let expected = true
    var error: Error?
    var result: Bool?

    repo.setError(to: false)
    repo.setData(data: true)

    // exec
    useCase.execute(request: nil)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished: break
        case .failure(let err): error = err
        }

        expectation.fulfill()
      }, receiveValue: { response in
        result = response
      })
      .store(in: &cancellables)
    waitForExpectations(timeout: 10)

    // expect
    XCTAssertNil(error)
    XCTAssertEqual(result, expected)
  }

  func test_returnSuccessFalse() {
    // setup
    let repo = RepositoryMock<GameUIModel, Bool>(data: false)
    let useCase = Interactor<
      GameUIModel,
      Bool,
      RepositoryMock<GameUIModel, Bool>
    >(repository: repo)

    // prepare
    let expectation = self.expectation(description: "should return success (no error)")
    let expected = false
    var error: Error?
    var result: Bool?

    repo.setError(to: false)
    repo.setData(data: false)

    // exec
    useCase.execute(request: nil)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished: break
        case .failure(let err): error = err
        }

        expectation.fulfill()
      }, receiveValue: { response in
        result = response
      })
      .store(in: &cancellables)
    waitForExpectations(timeout: 10)

    // expect
    XCTAssertNil(error)
    XCTAssertEqual(result, expected)
  }

  func test_returnError() {
    // setup
    let repo = RepositoryMock<GameUIModel, Bool>(data: true)
    let useCase = Interactor<
      GameUIModel,
      Bool,
      RepositoryMock<GameUIModel, Bool>
    >(repository: repo)

    // prepare
    let expectation = self.expectation(description: "should return error")
    var error: Error?
    var result: Bool?

    repo.setError(to: true)

    // exec
    useCase.execute(request: nil)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished: break
        case .failure(let err): error = err
        }

        expectation.fulfill()
      }, receiveValue: { response in
        result = response
      })
      .store(in: &cancellables)
    waitForExpectations(timeout: 10)

    // expect
    XCTAssertNotNil(error)
    XCTAssertNil(result)
  }
}
