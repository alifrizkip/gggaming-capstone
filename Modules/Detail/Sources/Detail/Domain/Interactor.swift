//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//

import GGGamingCore
import Common

public typealias GetDetailInteractor = Interactor<
  Int,
  GameUIModel,
  GetDetailRepository<DetailGameRemoteDataSource, DetailTransformer>
>

public typealias GetScreenshotsInteractor = Interactor<
  Int,
  [ScreenshotUIModel],
  GetScreenshotsRepository<ScreenshotRemoteDataSource, ScreenshotTransformer>
>

public typealias AddFavoriteInteractor = Interactor<
  GameUIModel, Bool, AddFavoriteRepository
>

public typealias CheckFavoriteInteractor = Interactor<
  Int, Bool, CheckFavoriteRepository
>

public typealias DeleteFavoriteInteractor = Interactor<
  Int, Bool, DeleteFavoriteRepository
>
