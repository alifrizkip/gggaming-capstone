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
@testable import Search

final class SearchInteractorTest: XCTestCase {
  private var cancellables: Set<AnyCancellable> = []

  func test_returnSuccess() {
    // setup
    let repo = RepositoryMock<String, [GameUIModel]>(data: [])
    let useCase = Interactor<
      String,
      [GameUIModel],
      RepositoryMock<String, [GameUIModel]>
    >(repository: repo)

    // prepare
    let expectation = self.expectation(description: "should return success (no error)")
    let expected: [GameUIModel] = [.stub, .stub]
    var error: Error?
    var result: [GameUIModel] = []

    repo.setError(to: false)
    repo.setData(data: [.stub, .stub])

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
    XCTAssertEqual(result.count, expected.count)
  }

  func test_returnError() {
    // setup
    let repo = RepositoryMock<String, [GameUIModel]>(data: [])
    repo.setError(to: true)
    let useCase = Interactor<
      String,
      [GameUIModel],
      RepositoryMock<String, [GameUIModel]>
    >(repository: repo)

    // prepare
    let expectation = self.expectation(description: "should return error")
    var error: Error?
    var result: [GameUIModel]?

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
