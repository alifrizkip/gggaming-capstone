//
//  ContentView.swift
//  GGGamingCapstone
//
//  Created by alip on 02/11/21.
//

import SwiftUI
import Search
import Profile
import Home
import Favorite

struct TabItem: Hashable {
  var tag: String
  var icon: String
  var activeIcon: String
}

var tabsItems = [
  TabItem(tag: "home", icon: "house", activeIcon: "house.fill"),
  TabItem(tag: "search", icon: "magnifyingglass", activeIcon: "magnifyingglass"),
  TabItem(tag: "favorite", icon: "bookmark", activeIcon: "bookmark.fill"),
  TabItem(tag: "profile", icon: "person", activeIcon: "person.fill")
]

struct ContentView: View {
  @State var selectedTab = "home"

  let homePresenter = Home.Injection.shared.providePresenter()
  let searchPresenter = Search.Injection.shared.providePresenter()
  let profilePresenter = Profile.Injection.shared.providePresenter()
  let favoritePresenter = Favorite.Injection.shared.providePresenter()

  var body: some View {
    NavigationView {
      ZStack(
        alignment: Alignment(
          horizontal: .center,
          vertical: .bottom
        )
      ) {
        TabView(selection: $selectedTab) {
          HomeView(presenter: homePresenter)
            .tag("home")

          SearchView(presenter: searchPresenter)
            .tag("search")

          FavoriteView(presenter: favoritePresenter)
            .tag("favorite")

          ProfileView(presenter: profilePresenter)
            .tag("profile")
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .padding(.bottom, 57)

        HStack(spacing: 0) {
          ForEach(tabsItems, id: \.self) {tabItem in
            TabButton(item: tabItem, selectedTab: $selectedTab)

            if tabItem.tag != tabsItems.last?.tag {
              Spacer(minLength: 0)
            }
          }
        }
        .padding(.horizontal, 35)
        .padding(.top, 1)
        .padding(.bottom, 1)
      }
      .ignoresSafeArea(.keyboard, edges: .bottom)
      .navigationTitle("")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarHidden(true)
    }
  }
}

struct TabButton: View {
  var item: TabItem
  @Binding var selectedTab: String

  var body: some View {
    Button { selectedTab = item.tag } label: {
      Image(systemName: selectedTab == item.tag ? item.activeIcon : item.icon)
        .resizable()
        .aspectRatio(1 / 1, contentMode: .fit)
        .frame(height: 25)
        .foregroundColor(selectedTab == item.tag ? Color("Primary") : Color("TextSecondary"))
        .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
