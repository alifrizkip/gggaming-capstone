//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Common

public protocol ProfileRepositoryProtocol {
  func getProfile() -> ProfileUIModel
  func updateProfile(_ profile: ProfileUIModel)
}

public class ProfileRepository: ProfileRepositoryProtocol {
  public static let shared = ProfileRepository()

  public init() {}

  public func getProfile() -> ProfileUIModel {
    let name = UserDefaultsService.shared.name
    let email = UserDefaultsService.shared.email
    let githubUsername = UserDefaultsService.shared.githubUsername
    let avatarName = UserDefaultsService.shared.avatarName

    return ProfileUIModel(
      name: name,
      email: email,
      githubUsername: githubUsername,
      avatarName: avatarName
    )
  }

  public func updateProfile(_ profile: ProfileUIModel) {
    UserDefaultsService.shared.update(name: profile.name, email: profile.email, githubUsername: profile.githubUsername)
  }
}
