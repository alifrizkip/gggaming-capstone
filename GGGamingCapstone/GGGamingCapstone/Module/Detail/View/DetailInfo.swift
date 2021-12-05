//
//  InfoDetail.swift
//  GGGamingCapstone
//
//  Created by alip on 06/11/21.
//

import SwiftUI
import Kingfisher
import Common

struct DetailInfo: View {
  let game: GameUIModel
  let screenshots: [ScreenshotUIModel]

  @State private var isShowMore = false
  @Binding var isFavorite: Bool
  var toggleFavorite: () -> Void

  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .bottom) {
        ForEach((1...5), id: \.self) { num in
          Image(systemName: num <= game.rating ? "star.fill" : "star")
            .foregroundColor(.yellow)
        }

        Spacer(minLength: 0)

        Button {
          withAnimation {
            toggleFavorite()
          }
        } label: {
          Image(systemName: isFavorite ? "bookmark.fill": "bookmark")
            .resizable()
            .frame(width: 20, height: 24)
            .foregroundColor(Color("Primary"))
        }
      }
      .padding(.bottom, 5)

      Text(game.name)
        .font(.largeTitle)
        .fontWeight(.bold)
        .lineLimit(nil)

      Text(game.released)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(game.genres) { genre in
            Text(genre.name)
              .font(.footnote)
              .fontWeight(.semibold)
              .foregroundColor(Color("Primary"))
              .padding(.vertical, 5)
              .padding(.horizontal)
              .background(
                ZStack {
                  Color("Secondary")
                    .clipShape(Capsule())
                }
              )
          }
        }
        .padding(.vertical, 10)
      }

      if !game.descriptionRaw.isEmpty {
        Text(game.descriptionRaw)
          .foregroundColor(Color("TextSecondary"))
          .lineLimit(isShowMore ? nil : 5)
          .padding(.bottom, 1)

        Button {
          withAnimation { isShowMore.toggle() }
        } label: {
          Text(isShowMore ? "hide".localizedLowercase : "more".toLocalized())
        }
      }

      screenshotsSection

      Spacer(minLength: 0)
    }
    .padding(.vertical, 30)
    .padding(.horizontal, 30)
  }
}

extension DetailInfo {
  var screenshotsSection: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(screenshots) { screenshot in
          KFImage(URL(string: screenshot.image))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(
              width: 250,
              height: 250 / 16 * 9,
              alignment: Alignment(horizontal: .center, vertical: .center)
            )
            .clipped()
            .cornerRadius(20)
            .padding(.trailing)
        }
      }
      .padding(.top)
    }
  }
}
