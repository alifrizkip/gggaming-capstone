//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//

import Swinject

import GGGamingCore
import Common

public class Injection {
  public static let shared = Injection()

  let c = Container()

  public init() {
    // detail
    let detailEndpoint = "/api/games"
    let detailRemote = DetailGameRemoteDataSource(endpoint: detailEndpoint)
    let detailMapper = DetailTransformer()
    let detailRepo = GetDetailRepository(remote: detailRemote, mapper: detailMapper)
    let detailUseCase = GetDetailInteractor(repository: detailRepo)
    c.register(GetDetailInteractor.self) { _ in detailUseCase }

    // screenshot
    let ssEndpoint = "/api/games"
    let ssRemote = ScreenshotRemoteDataSource(endpoint: ssEndpoint)
    let ssMapper = ScreenshotTransformer()
    let ssRepo = GetScreenshotsRepository(remote: ssRemote, mapper: ssMapper)
    let ssUseCase = GetScreenshotsInteractor(repository: ssRepo)
    c.register(GetScreenshotsInteractor.self) { _ in ssUseCase }

    // fav
    let addFavRepo = AddFavoriteRepository()
    let checkFavRepo = CheckFavoriteRepository()
    let deleteFavRepo = DeleteFavoriteRepository()
    c.register(AddFavoriteInteractor.self) { _ in
      AddFavoriteInteractor(repository: addFavRepo)
    }
    c.register(CheckFavoriteInteractor.self) { _ in
      CheckFavoriteInteractor(repository: checkFavRepo)
    }
    c.register(DeleteFavoriteInteractor.self) { _ in
      DeleteFavoriteInteractor(repository: deleteFavRepo)
    }
  }

  public func provideDetailUseCase() -> GetDetailInteractor {
    c.resolve(GetDetailInteractor.self)!
  }

  public func provideScreenshotUseCase() -> GetScreenshotsInteractor {
    c.resolve(GetScreenshotsInteractor.self)!
  }

  public func provideAddFavUseCase() -> AddFavoriteInteractor {
    c.resolve(AddFavoriteInteractor.self)!
  }

  public func provideCheckFavUseCase() -> CheckFavoriteInteractor {
    c.resolve(CheckFavoriteInteractor.self)!
  }

  public func provideDeleteFavUseCase() -> DeleteFavoriteInteractor {
    c.resolve(DeleteFavoriteInteractor.self)!
  }
}

