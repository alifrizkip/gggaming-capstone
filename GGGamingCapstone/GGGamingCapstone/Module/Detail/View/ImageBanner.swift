//
//  ImageBanner.swift
//  GGGamingCapstone
//
//  Created by alip on 06/11/21.
//

import SwiftUI
import Kingfisher

struct ImageBanner: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  let image: String
  let width: CGFloat

  var body: some View {
    ZStack(alignment: .top) {
      KFImage(URL(string: image)).placeholder {
        Image("placeholder")
      }
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(
        width: width,
        height: width / 4 * 5,
        alignment: Alignment(horizontal: .center, vertical: .center)
      )
      .clipped()
      .cornerRadius(60, corners: [.bottomLeft])

      HStack {
        Button {
          withAnimation(.spring()) {
            mode.wrappedValue.dismiss()
          }
        } label: {
          ZStack {
            Circle()
              .frame(width: 54, height: 54)
              .foregroundColor(.white)
              .opacity(0.6)

            Image(systemName: "chevron.backward")
              .resizable()
              .aspectRatio(1 / 2, contentMode: .fit)
              .frame(height: 25)
              .foregroundColor(Color("Primary"))
              .offset(x: -2)
          }
        }

        Spacer(minLength: 0)
      }
      .padding(.top, 40)
      .padding(.horizontal, 20)
      .foregroundColor(.white)
    }
  }
}
