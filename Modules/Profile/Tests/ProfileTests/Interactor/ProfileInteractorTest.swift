//
//  File.swift
//  
//
//  Created by alip on 05/12/21.
//

import XCTest

import Common
@testable import Profile

final class ProfileInteractorTest: XCTestCase {
  func test_getProfile() {
    let useCase = ProfileInteractor(repository: ProfileRepositoryMock())

    let expected: ProfileUIModel = .stub
    let result = useCase.getProfile()


    XCTAssertEqual(result.name, expected.name)
  }

  func test_update() {
    let repo = ProfileRepositoryMock()
    let useCase = ProfileInteractor(repository: repo)

    let expected = true
    useCase.update(profile: .stub)
    let result = repo.isHasBeenCalled

    XCTAssertEqual(result, expected)
  }
}
