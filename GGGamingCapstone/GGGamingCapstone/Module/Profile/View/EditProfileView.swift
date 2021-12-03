//
//  EditProfileView.swift
//  GGGamingCapstone
//
//  Created by alip on 15/11/21.
//

import SwiftUI
import Profile

struct EditProfileView: View {
  @ObservedObject var presenter: Profile.ProfilePresenter

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("Update Profile")
          .font(.largeTitle)
          .padding(.top, 10)

        Spacer(minLength: 0)
      }
      .padding(.bottom)

      VStack {
        HStack {
          Text("Name")
            .font(.body)
          Spacer(minLength: 0)
        }

        TextField("Name", text: $presenter.name)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .padding(.bottom, 5)

      VStack {
        HStack {
          Text("Github Username")
            .font(.body)
          Spacer(minLength: 0)
        }

        TextField("Github Username", text: $presenter.githubUsername)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .padding(.bottom, 5)

      VStack {
        HStack {
          Text("Email")
            .font(.body)
          Spacer(minLength: 0)
        }

        TextField("Email", text: $presenter.email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .padding(.bottom)

      Button {
        withAnimation(.spring()) {
          presenter.updateProfile()
          presenter.isEdit.toggle()
        }
      } label: {
        Text("Save")
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
