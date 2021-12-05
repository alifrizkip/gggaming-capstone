//
//  FavoriteView.swift
//  GGGamingCapstone
//
//  Created by alip on 14/11/21.
//

import SwiftUI
import Common
import Favorite

struct FavoriteView: View {
  @ObservedObject var presenter: Favorite.FavoritePresenter

  var body: some View {
    VStack {
      HStack {
        Text("favorite_title".toLocalized())
          .font(.largeTitle)
          .padding(.top, 10)

        Spacer(minLength: 0)
      }

      if !presenter.isLoading {
        if presenter.errorMessage == nil {
          if !presenter.list.isEmpty {
            ScrollView(.vertical, showsIndicators: false) {
              VStack(alignment: .leading) {
                ForEach(presenter.list) { game in
                  linkBuilder(for: game.id) {
                    GameRow(game: game)
                  }
                }
              }
            }
          } else {
            Spacer(minLength: 0)
            BaseInfoView(icon: "gamecontroller", message: "No data")
            Spacer(minLength: 0)
          }
        } else {
          Spacer(minLength: 0)
          BaseInfoView(
            icon: "exclamationmark.triangle",
            message: presenter.errorMessage ?? "Something's went wrong",
            color: .red
          )
          Spacer(minLength: 0)
        }
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          GamesListLoadingView()
        }
      }
    }
    .padding(.horizontal, 30)
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .onAppear {
      presenter.getList(request: nil)
    }
  }
}

extension FavoriteView {
  func linkBuilder<Content: View>(
    for gameID: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: DetailRouter().makeDetailView(for: gameID)) {
      content()
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    let presenter = Favorite.Injection.shared.providePresenter()
    FavoriteView(presenter: presenter)
  }
}
