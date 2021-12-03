//
//  DetailView.swift
//  GGGamingCapstone
//
//  Created by alip on 06/11/21.
//

import SwiftUI
import AlertToast
import Common
import Detail

struct DetailView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>

  @ObservedObject var presenter: Detail.PageDetailPresenter

  @State var isFavorite = false
  var body: some View {
    VStack {
      VStack {
        if !presenter.isLoading {
          if presenter.errorMessage == nil {
            if presenter.game != nil {
              succesSection
            }
          } else {
            errorSection
          }
        } else {
          LoadingDetail()
        }
      }
      .navigationBarTitle("")
      .navigationBarHidden(true)
      .edgesIgnoringSafeArea(.top)
      .foregroundColor(Color("TextPrimary"))
      .onAppear {
        presenter.getGame()
        presenter.getScreenshots()
      }
    }
    .toast(isPresenting: $presenter.isShowAlert) {
      AlertToast(
        displayMode: .banner(.pop),
        type: presenter.isFavorite ? .complete(.green) : .error(.red),
        title: presenter.isFavorite ? "Added to Wishlists" : "Removed from Wishlists"
      )
    }
  }
}

extension DetailView {
  var succesSection: some View {
    GeometryReader { geo in
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading) {
          ImageBanner(
            image: presenter.game?.backgroundImage ?? Common.API.defaultImageURL,
            width: geo.size.width
          )
          DetailInfo(
            game: presenter.game ?? .stub,
            screenshots: presenter.screenshots,
            isFavorite: $presenter.isFavorite,
            toggleFavorite: presenter.toggleFavorite
          )
        }
      }
    }
  }

  var errorSection: some View {
    VStack {
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

      Spacer(minLength: 0)
      BaseInfoView(
        icon: "exclamationmark.triangle",
        message: presenter.errorMessage ?? "Something's went wrong",
        color: .red
      )
      Spacer(minLength: 0)
    }
  }
}
