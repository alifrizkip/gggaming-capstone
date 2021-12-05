//
//  File.swift
//  
//
//  Created by alip on 05/12/21.
//

import Common
import Profile

class ProfileRepositoryMock: ProfileRepositoryProtocol {
  static let shared = ProfileRepositoryMock()

  var isHasBeenCalled = false

  func getProfile() -> ProfileUIModel {
    .stub
  }

  func updateProfile(_ profile: ProfileUIModel) {
    isHasBeenCalled = true
  }
}
