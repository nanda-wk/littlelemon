//
//  UserProfile.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import SwiftUI

struct UserProfile: View {
    @State private var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State private var isEditing = false
    @State private var isLoggedOut = false

    var body: some View {
        Form {
            VStack {
                HStack {
                    Spacer()

                    Button(isEditing ? "Save" : "Edit") {
                        save()
                        isEditing.toggle()
                    }
                    .foregroundStyle(.primary1)
                }
                Text("Personal information")
                    .font(.title)
                    .fontWeight(.bold)

                Image(.profileImagePlaceholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)

                Spacer()
                    .frame(height: 80)

                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("First Name: ")
                            .font(.headline)

                        TextField("", text: $firstName)
                            .disabled(!isEditing)
                            .font(.body)
                    }

                    VStack(alignment: .leading) {
                        Text("Last Name: ")
                            .font(.headline)

                        TextField("", text: $lastName)
                            .disabled(!isEditing)
                            .font(.body)
                    }

                    VStack(alignment: .leading) {
                        Text("Email: ")
                            .font(.headline)

                        TextField("", text: $email)
                            .disabled(!isEditing)
                            .font(.body)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button(action: logout) {
                    AppButton(title: "Logout")
                }
            }
        }
        .formStyle(.columns)
        .foregroundStyle(.highlight2)
        .padding()
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
            lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
            email = UserDefaults.standard.string(forKey: kEmail) ?? ""
        }
        .navigationDestination(isPresented: $isLoggedOut) {
            Onboarding()
        }
    }

    private func save() {
        if isEditing, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, email.isValidEmail {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email.trimmingCharacters(in: .whitespaces).lowercased(), forKey: kEmail)
        } else {
            return
        }
    }

    private func logout() {
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        UserDefaults.standard.set("", forKey: kFirstName)
        UserDefaults.standard.set("", forKey: kLastName)
        UserDefaults.standard.set("", forKey: kEmail)
        isLoggedOut = true
    }
}

#Preview {
    NavigationStack {
        UserProfile()
    }
}
