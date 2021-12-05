//
//  SearchView.swift
//  GGGamingCapstone
//
//  Created by alip on 05/11/21.
//

import SwiftUI
import Common
import Search

struct SearchView: View {
  @ObservedObject var presenter: Search.SearchPresenter
  @State private var isTyping = false

  var body: some View {
    VStack {
      inputField
        .padding(.vertical, 10)

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
            BaseInfoView(icon: "gamecontroller", message: "no_data".toLocalized())
            Spacer(minLength: 0)
          }
        } else {
          Spacer(minLength: 0)
          BaseInfoView(
            icon: "exclamationmark.triangle",
            message: presenter.errorMessage ?? "something_wrong".toLocalized(),
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
      if presenter.list.isEmpty {
        presenter.search(keyword: presenter.keyword)
      }
    }
    .onTapGesture {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
  }
}

extension SearchView {
  var inputField: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .font(.title3)
        .foregroundColor(.gray)

      TextField("search_placeholder".toLocalized(), text: $presenter.keyword)
        .font(.headline)
        .onTapGesture {
          isTyping = true
        }

      if isTyping {
        Button {
          presenter.keyword = ""
        } label: {
          Image(systemName: "multiply.circle.fill")
            .foregroundColor(.gray)
        }
      }
    }
    .padding(.vertical, 14)
    .padding(.horizontal, 16)
    .frame(height: 54)
    .overlay(
      RoundedRectangle(cornerRadius: 27)
        .stroke(Color.gray, lineWidth: 1)
    )
    .padding(.vertical, 1)
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

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    let presenter = Search.Injection.shared.providePresenter()
    SearchView(presenter: presenter)
  }
}
