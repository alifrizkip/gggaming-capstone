//
//  File.swift
//  
//
//  Created by alip on 30/11/21.
//

import SwiftUI

public struct BaseInfoView: View {
  var icon: String
  var message: String
  var color: Color = .gray

  public init(icon: String, message: String, color: Color = .gray) {
    self.icon = icon
    self.message = message
    self.color = color
  }

  public var body: some View {
    VStack {
      Image(systemName: icon)
        .font(.system(size: 75))
        .padding(.bottom)

      Text(message)
        .font(.title)
        .fontWeight(.medium)
    }
    .foregroundColor(color)
  }
}
