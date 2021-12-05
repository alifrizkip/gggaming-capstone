//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//  swiftlint:disable force_unwrapping

import Swinject

import GGGamingCore
import Common

public class Injection {
  public static let shared = Injection()

  let container = Container()

  public init() {
    // detail
    let detailEndpoint = "/api/games"
    let detailRemote = DetailGameRemoteDataSource(endpoint: detailEndpoint)
    let detailMapper = DetailTransformer()
    let detailRepo = GetDetailRepository(remote: detailRemote, mapper: detailMapper)
    let detailUseCase = GetDetailInteractor(repository: detailRepo)
    container.register(GetDetailInteractor.self) { _ in detailUseCase }

    // screenshot
    let ssEndpoint = "/api/games"
    let ssRemote = ScreenshotRemoteDataSource(endpoint: ssEndpoint)
    let ssMapper = ScreenshotTransformer()
    let ssRepo = GetScreenshotsRepository(remote: ssRemote, mapper: ssMapper)
    let ssUseCase = GetScreenshotsInteractor(repository: ssRepo)
    container.register(GetScreenshotsInteractor.self) { _ in ssUseCase }

    // fav
    let addFavRepo = AddFavoriteRepository()
    let checkFavRepo = CheckFavoriteRepository()
    let deleteFavRepo = DeleteFavoriteRepository()
    container.register(AddFavoriteInteractor.self) { _ in
      AddFavoriteInteractor(repository: addFavRepo)
    }
    container.register(CheckFavoriteInteractor.self) { _ in
      CheckFavoriteInteractor(repository: checkFavRepo)
    }
    container.register(DeleteFavoriteInteractor.self) { _ in
      DeleteFavoriteInteractor(repository: deleteFavRepo)
    }
  }

  public func provideDetailUseCase() -> GetDetailInteractor {
    container.resolve(GetDetailInteractor.self)!
  }

  public func provideScreenshotUseCase() -> GetScreenshotsInteractor {
    container.resolve(GetScreenshotsInteractor.self)!
  }

  public func provideAddFavUseCase() -> AddFavoriteInteractor {
    container.resolve(AddFavoriteInteractor.self)!
  }

  public func provideCheckFavUseCase() -> CheckFavoriteInteractor {
    container.resolve(CheckFavoriteInteractor.self)!
  }

  public func provideDeleteFavUseCase() -> DeleteFavoriteInteractor {
    container.resolve(DeleteFavoriteInteractor.self)!
  }
}
