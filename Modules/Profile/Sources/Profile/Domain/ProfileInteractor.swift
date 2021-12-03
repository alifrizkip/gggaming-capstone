//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Common

public protocol ProfileUseCase {
  func getProfile() -> ProfileUIModel
  func update(profile: ProfileUIModel)
}

public class ProfileInteractor: ProfileUseCase {
  private let repository: ProfileRepositoryProtocol

  public init(repository: ProfileRepositoryProtocol) {
    self.repository = repository
  }

  public func getProfile() -> ProfileUIModel {
    repository.getProfile()
  }

  public func update(profile: ProfileUIModel) {
    repository.updateProfile(profile)
  }
}
