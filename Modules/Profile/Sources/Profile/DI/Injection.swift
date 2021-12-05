//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//  swiftlint:disable force_unwrapping

import Swinject
import GGGamingCore
import Common

public class Injection {
  public static let shared = Injection()

  let container = Container()

  public init() {
    let repo = ProfileRepository()
    let useCase = ProfileInteractor(repository: repo)
    let presenter = ProfilePresenter(profileUseCase: useCase)

    container.register(ProfilePresenter.self) { _ in presenter }
  }

  public func providePresenter() -> ProfilePresenter {
    container.resolve(ProfilePresenter.self)!
  }
}
