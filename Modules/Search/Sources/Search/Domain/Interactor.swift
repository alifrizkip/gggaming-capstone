//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import GGGamingCore
import Common

public typealias SearchInteractor = Interactor<
  String,
  [GameUIModel],
  SearchRepository<SearchGameRemoteDataSource, SearchTransformer>
>
