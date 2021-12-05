//
//  File.swift
//  
//
//  Created by alip on 01/12/21.
//

import Foundation
import Combine

import GGGamingCore
import Common

public class PageDetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let detailUseCase: GetDetailInteractor
  private let ssUseCase: GetScreenshotsInteractor
  private let addFavUseCase: AddFavoriteInteractor
  private let checkFavUseCase: CheckFavoriteInteractor
  private let deleteFavUseCase: DeleteFavoriteInteractor

  public let gameID: Int

  @Published public var game: GameUIModel?
  @Published public var screenshots: [ScreenshotUIModel] = []
  @Published public var errorMessage: String?
  @Published public var isLoading = false
  @Published public var isFavorite = false
  @Published public var isShowAlert = false

  public init(
    detailUseCase: GetDetailInteractor,
    ssUseCase: GetScreenshotsInteractor,
    addFavUseCase: AddFavoriteInteractor,
    checkFavUseCase: CheckFavoriteInteractor,
    deleteFavUseCase: DeleteFavoriteInteractor,
    gameID: Int
  ) {
    self.detailUseCase = detailUseCase
    self.ssUseCase = ssUseCase
    self.addFavUseCase = addFavUseCase
    self.checkFavUseCase = checkFavUseCase
    self.deleteFavUseCase = deleteFavUseCase
    self.gameID = gameID

    checkFavorite()
  }

  public func getGame() {
    isLoading = true
    errorMessage = nil
    detailUseCase.execute(request: gameID)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
        case .finished: break
        }
        self.isLoading = false
      }, receiveValue: { item in
        self.game = item
      })
      .store(in: &cancellables)
  }

  public func getScreenshots() {
    ssUseCase.execute(request: gameID)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in }, receiveValue: { screenshots in
        self.screenshots = screenshots
      })
      .store(in: &cancellables)
  }

  public func toggleFavorite() {
    if isFavorite {
      deleteFavorite()
    } else {
      addFavorite()
    }
  }

  private func checkFavorite() {
    checkFavUseCase.execute(request: gameID)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in }, receiveValue: { result in
        self.isFavorite = result
      })
      .store(in: &cancellables)
  }

  private func addFavorite() {
    guard let game = self.game else { return }

    addFavUseCase.execute(request: game)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in }, receiveValue: { [self] result in
        self.checkFavorite()
        if result {
          isShowAlert.toggle()
        }
      })
      .store(in: &cancellables)
  }

  private func deleteFavorite() {
    deleteFavUseCase.execute(request: gameID)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { _ in }, receiveValue: { [self] result in
        self.checkFavorite()
        if result {
          isShowAlert.toggle()
        }
      })
      .store(in: &cancellables)
  }
}
