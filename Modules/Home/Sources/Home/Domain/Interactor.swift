//
//  File.swift
//  
//
//  Created by alip on 02/12/21.
//

import GGGamingCore
import Common

public typealias HomeInteractor = Interactor<String, [GameUIModel], HomeRepository<GamesListRemoteDataSource, HomeTransformer>>
