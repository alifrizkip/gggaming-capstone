//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//

import GGGamingCore
import Common

public typealias ListFavoriteInteractor = Interactor<
  String,
  [GameUIModel],
  ListFavoriteRepository<ListFavoriteTransformer>
>
