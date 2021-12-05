//
//  Injection.swift
//  
//
//  Created by alip on 30/11/21.
//  swiftlint:disable force_unwrapping

import Swinject
import GGGamingCore
import Common

public class Injection {
  public static let shared = Injection()

  let container = Container()

  public init() {
    let endpoint = "/api/games"
    let remote = SearchGameRemoteDataSource(endpoint: endpoint)
    let mapper = SearchTransformer()
    let repo = SearchRepository(remote: remote, mapper: mapper)
    let useCase = SearchInteractor(repository: repo)
    let presenter = SearchPresenter(useCase: useCase)

    container.register(SearchInteractor.self) { _ in useCase }
    container.register(SearchPresenter.self) { _ in presenter }
  }

  public func providePresenter() -> SearchPresenter {
    container.resolve(SearchPresenter.self)!
  }
}
