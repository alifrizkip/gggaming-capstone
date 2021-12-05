//
//  EditProfileView.swift
//  GGGamingCapstone
//
//  Created by alip on 15/11/21.
//

import SwiftUI
import Profile
import Common

struct EditProfileView: View {
  @ObservedObject var presenter: Profile.ProfilePresenter

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("edit_profile_title".toLocalized())
          .font(.largeTitle)
          .padding(.top, 10)

        Spacer(minLength: 0)
      }
      .padding(.bottom)

      VStack {
        HStack {
          Text("name".toLocalized())
            .font(.body)
          Spacer(minLength: 0)
        }

        TextField("name".toLocalized(), text: $presenter.name)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .padding(.bottom, 5)

      VStack {
        HStack {
          Text("github_username".toLocalized())
            .font(.body)
          Spacer(minLength: 0)
        }

        TextField("github_username".toLocalized(), text: $presenter.githubUsername)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .padding(.bottom, 5)

      VStack {
        HStack {
          Text("email".toLocalized())
            .font(.body)
          Spacer(minLength: 0)
        }

        TextField("email".toLocalized(), text: $presenter.email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .padding(.bottom)

      Button {
        withAnimation(.spring()) {
          presenter.updateProfile()
          presenter.isEdit.toggle()
        }
      } label: {
        Text("save".toLocalized())
          .foregroundColor(.white)
          .padding(.vertical, 8)
          .padding(.horizontal)
          .background(Color("Primary"))
      }

      Spacer(minLength: 0)
    }
    .foregroundColor(Color("TextPrimary"))
    .padding(.horizontal, 30)
  }
}

struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
    let profilePresenter = Profile.Injection.shared.providePresenter()

    EditProfileView(presenter: profilePresenter)
  }
}
