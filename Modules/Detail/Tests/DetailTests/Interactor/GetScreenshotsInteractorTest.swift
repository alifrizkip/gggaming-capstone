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

final class GetScreenshotsInteractorTest: XCTestCase {
  private var cancellables: Set<AnyCancellable> = []

  func test_returnSuccess() {
    // setup
    let repo = RepositoryMock<Int, [ScreenshotUIModel]>(data: [])
    let useCase = Interactor<
      Int,
      [ScreenshotUIModel],
      RepositoryMock<Int, [ScreenshotUIModel]>
    >(repository: repo)

    // prepare
    let expectation = self.expectation(description: "should return success (no error)")
    let expected: [ScreenshotUIModel] = [.stub, .stub]
    var error: Error?
    var result: [ScreenshotUIModel] = []

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
    let repo = RepositoryMock<Int, [ScreenshotUIModel]>(data: [])
    repo.setError(to: true)
    let useCase = Interactor<
      Int,
      [ScreenshotUIModel],
      RepositoryMock<Int, [ScreenshotUIModel]>
    >(repository: repo)

    // prepare
    let expectation = self.expectation(description: "should return error")
    var error: Error?
    var result: [ScreenshotUIModel]?

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
