//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//

import Swinject

import GGGamingCore
import Common

public class Injection {
  public static let shared  = Injection()

  let c = Container()

  public init() {
    let listFavMapper = ListFavoriteTransformer()
    let listFavRepo = ListFavoriteRepository(mapper: listFavMapper)
    let listFavUseCase = ListFavoriteInteractor(repository: listFavRepo)
    let favPresenter = FavoritePresenter(useCase: listFavUseCase)

    c.register(ListFavoriteInteractor.self) { _ in listFavUseCase }
    c.register(FavoritePresenter.self) { _ in favPresenter }
  }

  public func provideUseCase() -> ListFavoriteInteractor  {
    c.resolve(ListFavoriteInteractor.self)!
  }

  public func providePresenter() -> FavoritePresenter {
    c.resolve(FavoritePresenter.self)!
  }
}
