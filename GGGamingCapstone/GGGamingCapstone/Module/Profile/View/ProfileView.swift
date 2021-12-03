//
//  ProfileView.swift
//  GGGamingCapstone
//
//  Created by alip on 15/11/21.
//

import SwiftUI
import Profile

struct ProfileView: View {
  @ObservedObject var presenter: Profile.ProfilePresenter

  var body: some View {
    VStack(alignment: .center) {
      HStack {
        Text("About me")
          .font(.largeTitle)
          .padding(.top, 10)

        Spacer(minLength: 0)

        Button {
          withAnimation(.spring()) {
            presenter.isEdit.toggle()
          }
        } label: {
          Image(systemName: "square.and.pencil")
            .font(.title2)
            .sheet(isPresented: $presenter.isEdit) {
              EditProfileView(presenter: presenter)
            }
        }
      }

      Image(presenter.avatarName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(
          width: 200,
          height: 200,
          alignment: Alignment(horizontal: .center, vertical: .center)
        )
        .clipShape(Circle())
        .padding(.top, 100)

      Text(presenter.name)
        .font(.title)
        .padding(.top)

      if let githubLink = URL(string: "https://github.com/\(presenter.githubUsername)") {
        Link("github.com/\(presenter.githubUsername)", destination: githubLink)
          .font(.title2)
          .padding(.top, 5)
          .foregroundColor(.blue)
      }

      HStack {
        Image(systemName: "envelope.fill")

        Text(presenter.email)
      }
      .font(.title2)
      .padding(.top, 5)

      Spacer(minLength: 0)
    }
    .padding(.horizontal, 30)
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .foregroundColor(Color("TextPrimary"))
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    let profilePresenter = Profile.Injection.shared.providePresenter()

    ProfileView(presenter: profilePresenter)
  }
}
