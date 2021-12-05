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
    let endpoint = "/api/games"
    let remote = GamesListRemoteDataSource(endpoint: endpoint)
    let mapper = HomeTransformer()
    let repo = HomeRepository(remote: remote, mapper: mapper)
    let useCase = HomeInteractor(repository: repo)
    let presenter = HomePresenter(useCase: useCase)

    container.register(HomeInteractor.self) { _ in useCase }
    container.register(HomePresenter.self) { _ in presenter }
  }

  public func providePresenter() -> HomePresenter {
    container.resolve(HomePresenter.self)!
  }
}
