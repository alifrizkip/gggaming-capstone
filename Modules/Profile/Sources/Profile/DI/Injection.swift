//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import Swinject
import GGGamingCore
import Common

public class Injection {
  public static let shared = Injection()

  let c = Container()

  public init() {
    let repo = ProfileRepository()
    let useCase = ProfileInteractor(repository: repo)
    let presenter = ProfilePresenter(profileUseCase: useCase)

    c.register(ProfilePresenter.self) { _ in presenter }
  }

  public func providePresenter() -> ProfilePresenter {
    c.resolve(ProfilePresenter.self)!
  }
}
