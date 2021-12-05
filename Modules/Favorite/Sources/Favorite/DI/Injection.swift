//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//  swiftlint:disable force_unwrapping

import Swinject

import GGGamingCore
import Common

public class Injection {
  public static let shared = Injection()

  let container = Container()

  public init() {
    let listFavMapper = ListFavoriteTransformer()
    let listFavRepo = ListFavoriteRepository(mapper: listFavMapper)
    let listFavUseCase = ListFavoriteInteractor(repository: listFavRepo)
    let favPresenter = FavoritePresenter(useCase: listFavUseCase)

    container.register(ListFavoriteInteractor.self) { _ in listFavUseCase }
    container.register(FavoritePresenter.self) { _ in favPresenter }
  }

  public func provideUseCase() -> ListFavoriteInteractor {
    container.resolve(ListFavoriteInteractor.self)!
  }

  public func providePresenter() -> FavoritePresenter {
    container.resolve(FavoritePresenter.self)!
  }
}
