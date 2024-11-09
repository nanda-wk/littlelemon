//
//  Onboarding.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import SwiftUI

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    @State private var currentTab = 0

    var body: some View {
        NavigationStack {
            TabView(selection: $currentTab) {
                welcomeview
                    .tag(0)

                menusView
                    .tag(1)

                registerView
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .background(.secondary2)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear {
                isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
            }
        }
    }

    private var welcomeview: some View {
        VStack {
            Spacer()
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)

            Text("Welcome to Little Lemon! Delight in our fresh flavors and let us make your dining experience unforgettable.")
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundStyle(.highlight2)

            Spacer()

            HStack {
                Spacer()

                Button {
                    withAnimation {
                        currentTab = 1
                    }
                } label: {
                    AppButton(title: "Next")
                        .foregroundStyle(.highlight2)
                }
                .frame(maxWidth: UIScreen.main.bounds.width / 3)
            }
            .padding()

            Spacer()
                .frame(height: 40)
        }
    }

    private var menusView: some View {
        VStack {
            Spacer()

            Image(.pasta)
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text("Discover our curated menu, packed with fresh, flavorful dishes crafted to delight your taste buds. Enjoy a taste adventure at Little Lemon!")
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundStyle(.highlight2)

            Spacer()

            HStack {
                Button {
                    withAnimation {
                        currentTab = 0
                    }
                } label: {
                    AppButton(title: "Back")
                        .foregroundStyle(.highlight2)
                }
                .frame(maxWidth: UIScreen.main.bounds.width / 3)

                Spacer()

                Button {
                    withAnimation {
                        currentTab = 2
                    }
                } label: {
                    AppButton(title: "Next")
                        .foregroundStyle(.highlight2)
                }
                .frame(maxWidth: UIScreen.main.bounds.width / 3)
            }
            .padding()

            Spacer()
                .frame(height: 40)
        }
    }

    private var registerView: some View {
        Form {
            VStack {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)

                Text("Register")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.highlight2)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
                .frame(height: 90)

            VStack(spacing: 20) {
                TextField("First Name", text: $firstName)

                TextField("Last Name", text: $lastName)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            .textFieldStyle(.roundedBorder)

            Spacer()
                .frame(height: 60)

            Button(action: register) {
                AppButton(title: "Register")
            }

            Spacer()
        }
        .formStyle(.columns)
        .foregroundStyle(.highlight2)
        .padding()
    }

    private func register() {
        if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, email.isValidEmail {
            isLoggedIn = true
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email.trimmingCharacters(in: .whitespaces).lowercased(), forKey: kEmail)
            UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
        } else {
            isLoggedIn = false
        }
    }
}

#Preview {
    Onboarding()
}
