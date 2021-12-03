//
//  LoadingDetail.swift
//  GGGamingCapstone
//
//  Created by alip on 06/11/21.
//

import SwiftUI
import Common

struct LoadingDetail: View {
  @State var isFavorite = false
  let dummy: GameUIModel = .stub

  var body: some View {
    GeometryReader { geo in
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          ImageBanner(image: dummy.backgroundImage, width: geo.size.width)
          DetailInfo(game: dummy, screenshots: [], isFavorite: $isFavorite) {}
        }
      }.redacted(reason: .placeholder)
    }
  }
}
