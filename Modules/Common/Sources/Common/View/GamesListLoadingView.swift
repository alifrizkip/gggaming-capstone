//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import SwiftUI

public struct GamesListLoadingView: View {
  public init() {}

  public var body: some View {
    VStack(alignment: .leading) {
      ForEach((1...4), id: \.self) { _ in
        GameRow(game: .stub)
          .redacted(reason: .placeholder)
      }
    }
  }
}
