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
    let endpoint = "/api/games"
    let remote = GamesListRemoteDataSource(endpoint: endpoint)
    let mapper = HomeTransformer()
    let repo = HomeRepository(remote: remote, mapper: mapper)
    let useCase = HomeInteractor(repository: repo)
    let presenter = HomePresenter(useCase: useCase)

    c.register(HomeInteractor.self) { _ in useCase }
    c.register(HomePresenter.self) { _ in presenter }
  }

  public func providePresenter() -> HomePresenter {
    c.resolve(HomePresenter.self)!
  }
}
