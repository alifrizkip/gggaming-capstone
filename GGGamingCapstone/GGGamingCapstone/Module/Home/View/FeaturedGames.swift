//
//  FeaturedGames.swift
//  GGGamingCapstone
//
//  Created by alip on 05/11/21.
//

import SwiftUI
import Kingfisher
import Common
import Detail

struct FeaturedGames: View {
  let featuredGameIDs = [257255, 58175, 452634, 278, 58550]

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(featuredGameIDs, id: \.self) { gameID in
          FeaturedGameCardView(gameID: gameID)
        }
      }
    }
    .padding(.vertical, 5)
  }
}

struct FeaturedGameCardView: View {
  let gameID: Int

  @ObservedObject private var presenter: Detail.DetailPresenter

  init(gameID: Int) {
    self.gameID = gameID

    self.presenter = Detail.DetailPresenter(
      useCase: Detail.Injection.shared.provideDetailUseCase(),
      itemID: gameID
    )
  }

  var body: some View {
    linkBuilder(for: gameID) {
      bodyContent
    }
  }
}

extension FeaturedGameCardView {
  var bodyContent: some View {
    VStack {
      if !presenter.isLoading && presenter.errorMessage == nil && presenter.item != nil {
        if presenter.errorMessage == nil && presenter.item != nil {
          FeaturedGameCard(isLoading: $presenter.isLoading, game: presenter.item ?? .stub)
        }
      } else {
        FeaturedGameCard(isLoading: $presenter.isLoading, game: .stub)
          .redacted(reason: .placeholder)
      }
    }
    .onAppear {
      if presenter.item == nil {
        presenter.execute()
      }
    }
  }

  func linkBuilder<Content: View>(
    for gameID: Int,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: DetailRouter().makeDetailView(for: gameID)) {
      content()
    }
  }
}

struct FeaturedGameCard: View {
  @Binding var isLoading: Bool
  var game: GameUIModel

  var body: some View {
    VStack(alignment: .leading) {
      KFImage(URL(string: game.backgroundImage)).placeholder {
        Image("placeholder")
      }
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(
        width: 175,
        height: 175 / 3 * 4,
        alignment: Alignment(horizontal: .center, vertical: .center)
      )
      .clipped()
      .cornerRadius(20)
      .padding(.trailing)
      .padding(.bottom, 10)

      Text(game.name)
        .font(.title3)
        .fontWeight(.semibold)
        .foregroundColor(Color("TextPrimary"))
        .lineLimit(2)
        .multilineTextAlignment(.leading)
        .fixedSize(horizontal: false, vertical: true)

      Text(game.released)
        .font(.footnote)
        .foregroundColor(Color("TextPrimary"))
        .padding(.bottom, 1)

      HStack {
        ForEach((1...5), id: \.self) { num in
          Image(systemName: num <= game.rating ? "star.fill" : "star")
            .font(.footnote)
            .foregroundColor(.yellow)
        }
      }
      if !isLoading {
        Spacer(minLength: 0)
      }
    }
    .frame(width: 175)
    .padding(.leading)
  }
}
