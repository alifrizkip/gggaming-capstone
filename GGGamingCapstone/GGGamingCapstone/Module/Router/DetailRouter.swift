//
//  DetailRouter.swift
//  GGGamingCapstone
//
//  Created by alip on 01/12/21.
//

import SwiftUI
import Detail

class DetailRouter {
  func makeDetailView(for gameID: Int) -> some View {
    let detailUseCase = Detail.Injection.shared.provideDetailUseCase()
    let ssUseCase = Detail.Injection.shared.provideScreenshotUseCase()
    let addFavUseCase = Detail.Injection.shared.provideAddFavUseCase()
    let checkFavUseCase = Detail.Injection.shared.provideCheckFavUseCase()
    let deleteFavUseCase = Detail.Injection.shared.provideDeleteFavUseCase()

    let presenter = PageDetailPresenter(
      detailUseCase: detailUseCase,
      ssUseCase: ssUseCase,
      addFavUseCase: addFavUseCase,
      checkFavUseCase: checkFavUseCase,
      deleteFavUseCase: deleteFavUseCase,
      gameID: gameID
    )

    return DetailView(presenter: presenter)
  }
}
