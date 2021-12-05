//
//  HomeView.swift
//  GGGamingCapstone
//
//  Created by alip on 05/11/21.
//

import SwiftUI
import Common
import Home

struct HomeView: View {
  @ObservedObject var presenter: Home.HomePresenter
  @State var selectedGenre = "adventure"

  var body: some View {
    VStack(alignment: .leading) {
      headerSection
        .padding(.top, 10)

      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .leading) {
          FeaturedGames()
          genreFilterSection

          if !presenter.isLoading {
            if presenter.errorMessage == nil {
              if !presenter.list.isEmpty {
                ForEach(presenter.list) { game in
                  linkBuilder(for: game.id) {
                    GameRow(game: game)
                  }
                }
              } else {
                emptyDataSection
              }
            } else {
              errorSection
            }
          } else {
            GamesListLoadingView()
          }
        }
      }

      Spacer(minLength: 0)
    }
    .padding(.horizontal, 30)
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .onAppear {
      if presenter.list.isEmpty {
        presenter.getList(request: selectedGenre)
      }
    }
  }
}

extension HomeView {
  var headerSection: some View {
    HStack {
      Text("app_name".toLocalized())
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(Color("TextPrimary"))

      Spacer(minLength: 0)

      Button {
        withAnimation(.spring()) {}
      } label: {
        Image("avatar")
          .resizable()
          .frame(width: 42, height: 42)
          .clipShape(Circle())
      }
    }
    .padding(.vertical, 1)
  }

  var genresSection: [GenreUIModel] {
    return [
      GenreUIModel(id: 3, name: "Adventure", slug: "adventure"),
      GenreUIModel(id: 1, name: "Racing", slug: "racing"),
      GenreUIModel(id: 4, name: "Action", slug: "action"),
      GenreUIModel(id: 6, name: "Fighting", slug: "fighting"),
      GenreUIModel(id: 51, name: "Indie", slug: "indie"),
      GenreUIModel(id: 59, name: "MMO", slug: "massively-multiplayer"),
      GenreUIModel(id: 5, name: "RPG", slug: "role-playing-games-rpg"),
      GenreUIModel(id: 7, name: "Puzzle", slug: "puzzle")
    ]
  }

  var genreFilterSection: some View {
    VStack(alignment: .leading) {
      Text("genre".toLocalized())
        .font(.title2)
        .foregroundColor(Color("TextPrimary"))
        .padding(.top)
        .padding(.bottom, 5)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(genresSection) { genre in
            Button {
              withAnimation {
                if selectedGenre != genre.slug {
                  presenter.getList(request: genre.slug)
                }
              }
            } label: {
              Text(genre.name)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(Color(selectedGenre == genre.slug ? "Secondary" : "Primary"))
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(
                  ZStack {
                    Color(selectedGenre == genre.slug ? "Primary" : "Secondary")
                      .clipShape(Capsule())
                  }
                )
            }
          }
        }
      }
    }
    .padding(.bottom, 5)
  }

  var errorSection: some View {
    HStack {
      Spacer(minLength: 0)
      BaseInfoView(
        icon: "exclamationmark.triangle",
        message: presenter.errorMessage ?? "something_wrong".toLocalized(),
        color: .red
      )
      Spacer(minLength: 0)
    }
    .padding(.top)
    .padding(.bottom, 100)
  }

  var emptyDataSection: some View {
    HStack {
      Spacer(minLength: 0)
      BaseInfoView(icon: "gamecontroller", message: "no_data".toLocalized())
      Spacer(minLength: 0)
    }
    .padding(.top)
    .padding(.bottom, 100)
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

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let presenter = Home.Injection.shared.providePresenter()
    HomeView(presenter: presenter)
  }
}
