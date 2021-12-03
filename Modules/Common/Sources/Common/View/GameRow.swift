//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import SwiftUI
import Kingfisher

public struct GameRow: View {
  var game: GameUIModel

  public init(game: GameUIModel) {
    self.game = game
  }

  public var body: some View {
    HStack(alignment: .top, spacing: 0) {
      imageGame

      VStack(alignment: .leading, spacing: 5) {
        Text(game.released)
          .font(.caption2)
          .foregroundColor(Color("TextPrimary"))

        Text(game.name)
          .font(.title3)
          .fontWeight(.semibold)
          .lineLimit(2)
          .multilineTextAlignment(.leading)

        HStack {
          ForEach((1...5), id: \.self) { num in
            Image(systemName: num <= game.rating ? "star.fill" : "star")
              .font(.caption)
              .foregroundColor(.yellow)
          }
        }

        Text(game.genres.map { $0.name }.joined(separator: ", "))
          .font(.caption)
          .foregroundColor(.gray)
          .lineLimit(1)
      }
      .padding(.all, 10)

      Spacer(minLength: 0)
    }
    .foregroundColor(Color("TextPrimary") )
    .background(Color("Secondary"))
    .cornerRadius(20)
    .padding(.bottom, 10)
  }
}

extension GameRow {
  var imageGame: some View {
    KFImage(URL(string: game.backgroundImage)).placeholder {
      Image("placeholder")
    }
    .resizable()
    .aspectRatio(contentMode: .fill)
    .frame(
      width: 130 * 5 / 6,
      height: 130,
      alignment: Alignment(horizontal: .center, vertical: .center)
    )
    .clipped()
  }
}
