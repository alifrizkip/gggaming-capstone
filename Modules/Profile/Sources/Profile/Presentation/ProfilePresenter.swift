//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Foundation
import Common

public class ProfilePresenter: ObservableObject {
  private let profileUseCase: ProfileUseCase

  @Published public var isEdit = false
  @Published public var name = ""
  @Published public var email = ""
  @Published public var githubUsername = ""
  @Published public var avatarName = ""

  public init(profileUseCase: ProfileUseCase) {
    self.profileUseCase = profileUseCase

    setProfile()
  }

  private func setProfile() {
    let profile = profileUseCase.getProfile()

    name = profile.name
    email = profile.email
    githubUsername = profile.githubUsername
    avatarName = profile.avatarName
  }

  public func updateProfile() {
    let newProfile = ProfileUIModel(name: name, email: email, githubUsername: githubUsername, avatarName: avatarName)

    profileUseCase.update(profile: newProfile)
    setProfile()
  }
}
