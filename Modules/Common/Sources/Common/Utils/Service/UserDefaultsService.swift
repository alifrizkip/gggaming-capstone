//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Foundation

public class UserDefaultsService {
  public static let shared = UserDefaultsService()

  private let defaults = UserDefaults.standard
  private let nameKey = "Name"
  private let emailKey = "Email"
  private let githubUsernameKey = "GithubUsername"
  private let avatarNameKey = "AvatarName"

  public var name: String {
    defaults.string(forKey: nameKey) ?? "Alif Rizki Pambudi"
  }

  public var email: String {
    defaults.string(forKey: emailKey) ?? "alifrizkipambudi@gmail.com"
  }

  public var githubUsername: String {
    defaults.string(forKey: githubUsernameKey) ?? "alifrizkip"
  }

  public var avatarName: String {
    defaults.string(forKey: avatarNameKey) ?? "avatar"
  }

  public func update(name: String?, email: String?, githubUsername: String?) {
    if let name = name {
      defaults.setValue(name, forKey: nameKey)
    }
    if let githubUsername = githubUsername {
      defaults.setValue(githubUsername, forKey: githubUsernameKey)
    }
    if let email = email {
      defaults.setValue(email, forKey: emailKey)
    }
  }
}
